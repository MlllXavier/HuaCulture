package com.good_ghost.hua_culture.service;

import com.good_ghost.hua_culture.entity.*;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface CardService {

    void upload(HttpServletRequest request, MultipartFile multipartFile);

    List<Card> getCards();

    List<Card> getVideoCards();

    List<Card> getAudioCards();

    List<Card> getPhotoCards();

    List<Card> getArticleCards();

    List<Card> getCardsByCategory(String id);

    List<Card> getUserCards(int id);

    List<Card> getUserLikedCards(int id);

    List<Card> getUserCommentedCards(int id);

    List<Card> searchCards(String query);

    Video getVideoById(int id);

    Audio getAudioById(int id);

    List<Photo> getPhotosById(int id);

    Article getArticleById(int id);

    void likeCard(int user_id, int card_id);

    boolean getIsLike(int user_id, int card_id);

    void commentCard(int user_id, int card_id, String content);

    void passCard(int id);

    void notPassCard(int id);

    List<Comment> getCommentsById(int id);

}
