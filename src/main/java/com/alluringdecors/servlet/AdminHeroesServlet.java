package com.alluringdecors.servlet;

import com.alluringdecors.bean.HeroBean;
import com.alluringdecors.model.Hero;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/heroes")
public class AdminHeroesServlet extends HttpServlet {
    
    private HeroBean heroBean;
    
    @Override
    public void init() throws ServletException {
        super.init();
        heroBean = new HeroBean();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String ajax = request.getParameter("ajax");
        
        if ("delete".equals(action)) {
            int heroId = Integer.parseInt(request.getParameter("id"));
            heroBean.deleteHero(heroId);
            response.sendRedirect("heroes");
            return;
        }
        
        List<Hero> heroes = heroBean.getAllActiveHeroes();
        
        if ("true".equals(ajax)) {
            response.setContentType("text/html;charset=UTF-8");
            java.io.PrintWriter out = response.getWriter();
            
            out.println("<div class='dashboard-header'>");
            out.println("<div><h1 class='dashboard-title'>Manage Hero Carousel</h1>");
            out.println("<p class='dashboard-subtitle'>Create and manage hero slides for the home page</p></div>");
            out.println("<button class='header-action-btn' onclick='showAddHeroForm()'><i class='fas fa-plus'></i> Add Hero Slide</button>");
            out.println("</div>");
            
            out.println("<table class='admin-table'>");
            out.println("<thead><tr><th>ID</th><th>Title</th><th>Subtitle</th><th>Order</th><th>Actions</th></tr></thead>");
            out.println("<tbody>");
            
            if (heroes.isEmpty()) {
                out.println("<tr><td colspan='5' style='text-align:center; padding: 2rem; color: #666;'>No hero slides available. Click 'Add Hero Slide' to create one.</td></tr>");
            } else {
                for (Hero hero : heroes) {
                    String safeTitle = hero.getTitle().replace("\"", "&quot;");
                    String safeSubtitle = hero.getSubtitle() != null ? hero.getSubtitle().replace("\"", "&quot;") : "";
                    String safeBodyText = hero.getBodyText().replace("\"", "&quot;");
                    String safeImage = hero.getBackgroundImage() != null ? hero.getBackgroundImage().replace("\"", "&quot;") : "";
                    String safePrimaryBtn = hero.getPrimaryButton() != null ? hero.getPrimaryButton().replace("\"", "&quot;") : "";
                    String safePrimaryLink = hero.getPrimaryButtonLink() != null ? hero.getPrimaryButtonLink().replace("\"", "&quot;") : "";
                    String safeSecondaryBtn = hero.getSecondaryButton() != null ? hero.getSecondaryButton().replace("\"", "&quot;") : "";
                    String safeSecondaryLink = hero.getSecondaryButtonLink() != null ? hero.getSecondaryButtonLink().replace("\"", "&quot;") : "";
                    
                    out.println("<tr>");
                    out.println("<td>" + hero.getHeroId() + "</td>");
                    out.println("<td><strong>" + hero.getTitle() + "</strong></td>");
                    out.println("<td>" + (hero.getSubtitle() != null ? hero.getSubtitle() : "N/A") + "</td>");
                    out.println("<td>" + hero.getDisplayOrder() + "</td>");
                    out.println("<td>");
                    out.println("<button class='action-btn' onclick='showEditHeroForm(" + hero.getHeroId() + ", \"" + safeTitle + "\", \"" + safeSubtitle + "\", \"" + safeBodyText + "\", \"" + safeImage + "\", \"" + safePrimaryBtn + "\", \"" + safePrimaryLink + "\", \"" + safeSecondaryBtn + "\", \"" + safeSecondaryLink + "\", " + hero.getDisplayOrder() + ")'><i class='fas fa-edit'></i> Edit</button> ");
                    out.println("<a href='heroes?action=delete&id=" + hero.getHeroId() + "' class='action-btn delete' onclick='return confirm(\"Delete this hero slide?\")' style='text-decoration:none'><i class='fas fa-trash'></i> Delete</a>");
                    out.println("</td>");
                    out.println("</tr>");
                }
            }
            out.println("</tbody></table>");
        } else {
            request.setAttribute("heroes", heroes);
            request.getRequestDispatcher("/admin-heroes.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String heroIdStr = request.getParameter("heroId");
        String title = request.getParameter("title");
        String subtitle = request.getParameter("subtitle");
        String bodyText = request.getParameter("bodyText");
        String backgroundImage = request.getParameter("backgroundImage");
        String primaryButton = request.getParameter("primaryButton");
        String primaryButtonLink = request.getParameter("primaryButtonLink");
        String secondaryButton = request.getParameter("secondaryButton");
        String secondaryButtonLink = request.getParameter("secondaryButtonLink");
        int displayOrder = Integer.parseInt(request.getParameter("displayOrder"));
        
        if (heroIdStr != null && !heroIdStr.isEmpty()) {
            // Update existing hero
            int heroId = Integer.parseInt(heroIdStr);
            Hero hero = new Hero(title, subtitle, bodyText, backgroundImage);
            hero.setHeroId(heroId);
            hero.setPrimaryButton(primaryButton);
            hero.setPrimaryButtonLink(primaryButtonLink);
            hero.setSecondaryButton(secondaryButton);
            hero.setSecondaryButtonLink(secondaryButtonLink);
            hero.setDisplayOrder(displayOrder);
            heroBean.updateHero(hero);
        } else {
            // Add new hero
            Hero hero = new Hero(title, subtitle, bodyText, backgroundImage);
            hero.setPrimaryButton(primaryButton);
            hero.setPrimaryButtonLink(primaryButtonLink);
            hero.setSecondaryButton(secondaryButton);
            hero.setSecondaryButtonLink(secondaryButtonLink);
            hero.setDisplayOrder(displayOrder);
            heroBean.addHero(hero);
        }
        
        response.sendRedirect("heroes");
    }
}