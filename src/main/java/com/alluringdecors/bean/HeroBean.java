package com.alluringdecors.bean;

import com.alluringdecors.model.Hero;
import com.alluringdecors.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class HeroBean {
    
    public List<Hero> getAllActiveHeroes() {
        List<Hero> heroes = new ArrayList<>();
        String sql = "SELECT * FROM heroes WHERE is_active = 1 ORDER BY display_order";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                heroes.add(mapResultSetToHero(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return heroes;
    }
    
    public boolean addHero(Hero hero) {
        String sql = "INSERT INTO heroes (title, subtitle, body_text, background_image, primary_button, primary_button_link, secondary_button, secondary_button_link, display_order) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, hero.getTitle());
            stmt.setString(2, hero.getSubtitle());
            stmt.setString(3, hero.getBodyText());
            stmt.setString(4, hero.getBackgroundImage());
            stmt.setString(5, hero.getPrimaryButton());
            stmt.setString(6, hero.getPrimaryButtonLink());
            stmt.setString(7, hero.getSecondaryButton());
            stmt.setString(8, hero.getSecondaryButtonLink());
            stmt.setInt(9, hero.getDisplayOrder());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean updateHero(Hero hero) {
        String sql = "UPDATE heroes SET title = ?, subtitle = ?, body_text = ?, background_image = ?, primary_button = ?, primary_button_link = ?, secondary_button = ?, secondary_button_link = ?, display_order = ? WHERE hero_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, hero.getTitle());
            stmt.setString(2, hero.getSubtitle());
            stmt.setString(3, hero.getBodyText());
            stmt.setString(4, hero.getBackgroundImage());
            stmt.setString(5, hero.getPrimaryButton());
            stmt.setString(6, hero.getPrimaryButtonLink());
            stmt.setString(7, hero.getSecondaryButton());
            stmt.setString(8, hero.getSecondaryButtonLink());
            stmt.setInt(9, hero.getDisplayOrder());
            stmt.setInt(10, hero.getHeroId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean deleteHero(int heroId) {
        String sql = "UPDATE heroes SET is_active = 0 WHERE hero_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, heroId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    private Hero mapResultSetToHero(ResultSet rs) throws SQLException {
        Hero hero = new Hero();
        hero.setHeroId(rs.getInt("hero_id"));
        hero.setTitle(rs.getString("title"));
        hero.setSubtitle(rs.getString("subtitle"));
        hero.setBodyText(rs.getString("body_text"));
        hero.setBackgroundImage(rs.getString("background_image"));
        hero.setPrimaryButton(rs.getString("primary_button"));
        hero.setPrimaryButtonLink(rs.getString("primary_button_link"));
        hero.setSecondaryButton(rs.getString("secondary_button"));
        hero.setSecondaryButtonLink(rs.getString("secondary_button_link"));
        hero.setDisplayOrder(rs.getInt("display_order"));
        hero.setActive(rs.getBoolean("is_active"));
        return hero;
    }
}