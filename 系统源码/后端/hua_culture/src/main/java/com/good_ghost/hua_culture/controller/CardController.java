package com.good_ghost.hua_culture.controller;

import com.good_ghost.hua_culture.entity.*;
import com.good_ghost.hua_culture.service.CardService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/card")
public class CardController {

    @Autowired
    private CardService cardService;

    @PostMapping("/upload")
    public void upload(HttpServletRequest request, @RequestParam("multipartFile")MultipartFile multipartFile) {
        cardService.upload(request, multipartFile);
    }

    @RequestMapping("/getCards")
    public List<Card> getCards() {
        return cardService.getCards();
    }

    @RequestMapping("/getVideoCards")
    public List<Card> getVideoCards() {
        return cardService.getVideoCards();
    }

    @RequestMapping("/getAudioCards")
    public List<Card> getAudioCards() {
        return cardService.getAudioCards();
    }

    @RequestMapping("/getPhotoCards")
    public List<Card> getPhotoCards() {
        return cardService.getPhotoCards();
    }

    @RequestMapping("/getArticleCards")
    public List<Card> getArticleCards() {
        return cardService.getArticleCards();
    }

    @RequestMapping("/getCardsByCategory")
    public List<Card> getCardsByCategory(String id) {
        return cardService.getCardsByCategory(id);
    }

    @RequestMapping("/getUserCards")
    public List<Card> getUserCards(int id){
        return  cardService.getUserCards(id);
    }

    @RequestMapping("/getUserLikedCards")
    public List<Card> getUserLikedCards(int id){
        return  cardService.getUserLikedCards(id);
    }

    @RequestMapping("/getUserCommentedCards")
    public List<Card> getUserCommentedCards(int id){
        return  cardService.getUserCommentedCards(id);
    }

    @RequestMapping("/searchCards")
    public List<Card> searchCards(String query){
        return cardService.searchCards(query);
    }

    @RequestMapping("/getVideoById")
    Video getVideoById(int id) {
        return cardService.getVideoById(id);
    }

    @RequestMapping("/getAudioById")
    Audio getAudioById(int id) {
        return cardService.getAudioById(id);
    }

    @RequestMapping("/getPhotosById")
    List<Photo> getPhotosById(int id) {
        return cardService.getPhotosById(id);
    }

    @RequestMapping("/getArticleById")
    Article getArticleById(int id) {
        return cardService.getArticleById(id);
    }

    @RequestMapping("/likeCard")
    void likeCard(HttpServletRequest request){
        String user_id = request.getParameter("user_id");
        String card_id = request.getParameter("card_id");
        cardService.likeCard(Integer.parseInt(user_id), Integer.parseInt(card_id));
    }

    @RequestMapping("/getIsLike")
    boolean getIsLike(HttpServletRequest request){
        String user_id = request.getParameter("user_id");
        String card_id = request.getParameter("card_id");
        return cardService.getIsLike(Integer.parseInt(user_id), Integer.parseInt(card_id));
    }

    @RequestMapping("/commentCard")
    void commentCard(HttpServletRequest request){
        String user_id = request.getParameter("user_id");
        String card_id = request.getParameter("card_id");
        String content = request.getParameter("content");
        cardService.commentCard(Integer.parseInt(user_id), Integer.parseInt(card_id), content);
    }

    @RequestMapping("/getCommentsById")
    List<Comment> getCommentsById(int id){
        return cardService.getCommentsById(id);
    }

    @RequestMapping("/passCard")
    void passCard(int id){
        cardService.passCard(id);
    }

    @RequestMapping("/notPassCard")
    void notPassCard(int id){
        cardService.notPassCard(id);
    }

    @RequestMapping("/test")
    public String test() { return "OK"; }

}
