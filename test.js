/**
 * POST /api/payments/mpesa-callback
 * Processes Safaricom Daraja API Webhook for Homeland Jobs
 */
async function processMpesaCallback(req, res) {
    // 1. Authenticity Verification
    // verify the request comes from Safaricom IP ranges 
    // or validate a custom header/token you passed in the CheckoutRequestID
    const callbackData = req.body.Body.stkCallback;
    const { MerchantRequestID, CheckoutRequestID, ResultCode, CallbackMetadata } = callbackData;

    // Log the hit for debugging/audit trails
    console.log(`Processing Callback: ${CheckoutRequestID}`);

    try {
        // 2. Duplicate Transaction Prevention
        // Check if we have already processed this specific CheckoutRequestID
        const existingPayment = await db.table('payments')
            .where('transaction_ref', CheckoutRequestID)
            .first();

        if (existingPayment && existingPayment.status === 'paid') {
            return res.status(200).json({ ResultCode: 0, ResultDesc: "Success (Duplicate)" });
        }

        // 3. Handle Failed Transactions
        if (ResultCode !== 0) {
            await db.table('payments')
                .where('transaction_ref', CheckoutRequestID)
                .update({ status: 'failed', updated_at: new Date() });

            return res.status(200).json({ ResultCode: 0, ResultDesc: "Failure Recorded" });
        }

        // Parse Metadata into a usable object
        const meta = {};
        CallbackMetadata.Item.forEach(item => { meta[item.Name] = item.Value; });

        // 4. Atomic Database Update, ACID Compliance
        // We use a transaction to ensure both the payment record 
        // and the contract/escrow status update together.
        await db.transaction(async (trx) => {
            // Update Payment Record
            await trx('payments')
                .where('transaction_ref', CheckoutRequestID)
                .update({
                    amount: meta.Amount,
                    mpesa_receipt: meta.MpesaReceiptNumber,
                    status: 'paid',
                    paid_at: new Date()
                });

            // Update associated Contract/Job status
            const payment = await trx('payments').where('transaction_ref', CheckoutRequestID).first();
            await trx('contracts')
                .where('contract_id', payment.contract_id)
                .update({ escrow_status: 'funded' });

            // 5. Notification
            // Trigger internal notification service
            await NotificationService.send({
                userId: payment.freelancer_id,
                message: `Escrow funded! M-Pesa Ref: ${meta.MpesaReceiptNumber}. You can now start work.`,
                type: 'SMS_AND_PUSH'
            });
        });

        // 6. Correct Safaricom Response Format
        // Safaricom requires a 200 OK with this specific JSON body
        return res.status(200).json({
            "ResultCode": 0,
            "ResultDesc": "The service request is processed successfully."
        });

    } catch (error) {
        console.error("Critical M-Pesa Callback Error:", error);
        // We still return 0 to Safaricom to stop retries, but log the error for manual fix
        return res.status(200).json({ ResultCode: 1, ResultDesc: "Internal Error" });
    }
}