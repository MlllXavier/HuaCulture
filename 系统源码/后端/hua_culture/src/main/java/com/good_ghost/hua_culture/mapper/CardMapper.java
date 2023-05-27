package com.good_ghost.hua_culture.mapper;

import com.good_ghost.hua_culture.entity.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CardMapper {

    void saveCard(Card card);

    void saveVideo(Video video);

    void saveAudio(Audio audio);

    void savePhoto(Photo photo);

    void saveArticle(Article article);

    Video getVideo(int id);

    Audio getAudio(int id);

    List<Photo> getPhotos(int id);

    Article getArticle(int id);

    List<Card> getCards();

    List<Card> getUserCards(int id);

    List<Card> getUserLikedCards(int id);

    List<Card> getUserCommentedCards(int id);

    void likeCard(Like like);

    void updateUserLike(int id);

    void commentCard(Comment comment);

    void updateUserComment(int id);

    List<Like> getLikedCard(int id);

    void updateCardVerify(int id);

    void deleteCardById(int id);

    List<Comment> getCommentsById(int id);
}
