package com.good_ghost.hua_culture.service;

import com.good_ghost.hua_culture.entity.*;
import com.good_ghost.hua_culture.mapper.CardMapper;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Service("cardService")
public class CardServiceImpl implements CardService {

    @Resource
    private CardMapper cardMapper;

    @Override
    public void upload(HttpServletRequest request, MultipartFile multipartFile) {
        String user_id = request.getParameter("user_id");
        String intro = request.getParameter("intro");
        String types = request.getParameter("types");
        String classes = request.getParameter("classes");
        String source = request.getParameter("source");
        Card card = new Card();
        card.setCard_id(UUID.randomUUID().toString().hashCode());
        card.setUser_id(Integer.parseInt(user_id));
        card.setIntro(intro);
        card.setTypes(Integer.parseInt(types));
        card.setClasses(classes);
        card.setSource(source);
        card.set_checked(false);
        card.setTime(new Date(System.currentTimeMillis()));
        //获取上传源文件名
        String originalFilename = multipartFile.getOriginalFilename();
        //获取文件后缀
        String substring = originalFilename.substring(originalFilename.lastIndexOf("."));
        //保存的文件名
        Integer fileID = UUID.randomUUID().toString().hashCode();
        String dFileName = fileID.toString() + substring;
        String path = "D:/temp/" + dFileName;
        if (card.getTypes() == 0){
            Video video = new Video();
            video.setVideo_id(fileID);
            video.setGroup_id(0);
            video.setUsername(Integer.parseInt(user_id));
            video.setUrl("static/" + dFileName);
            video.setRatio(2.0);
            card.setVideo_id(fileID);
            cardMapper.saveVideo(video);
        }else if (card.getTypes() == 1){
            Audio audio = new Audio();
            audio.setAudio_id(fileID);
            audio.setGroup_id(0);
            audio.setUsername(Integer.parseInt(user_id));
            audio.setUrl("static/" + dFileName);
            card.setAudio_id(fileID);
            cardMapper.saveAudio(audio);
        }else if (card.getTypes() == 2){
            Photo photo = new Photo();
            photo.setPhoto_id(fileID);
            photo.setGroup_id(0);
            photo.setUsername(Integer.parseInt(user_id));
            photo.setUrl("static/" + dFileName);
            card.setPhoto_id(fileID);
            cardMapper.savePhoto(photo);
        }else if (card.getTypes() == 3){

        }else {
            return;
        }
        //将上传文件保存到路径
        try {
            File uploadFile = new File(path);
            System.out.println(uploadFile);
            multipartFile.transferTo(uploadFile);
        } catch (IOException e) {
            e.printStackTrace();
        }
        cardMapper.saveCard(card);
    }

    @Override
    public List<Card> getCards() {
        return cardMapper.getCards();
    }

    @Override
    public List<Card> getVideoCards() {
        List<Card> cards = cardMapper.getCards();
        List<Card> selectedCards = new ArrayList<>();
        for(int i = 0; i < cards.size(); i++){
            if(cards.get(i).getTypes() == 0){
                selectedCards.add(cards.get(i));
            }
        }
        return selectedCards;
    }

    @Override
    public List<Card> getAudioCards() {
        List<Card> cards = cardMapper.getCards();
        List<Card> selectedCards = new ArrayList<>();
        for(int i = 0; i < cards.size(); i++){
            if(cards.get(i).getTypes() == 1){
                selectedCards.add(cards.get(i));
            }
        }
        return selectedCards;
    }

    @Override
    public List<Card> getPhotoCards() {
        List<Card> cards = cardMapper.getCards();
        List<Card> selectedCards = new ArrayList<>();
        for(int i = 0; i < cards.size(); i++){
            if(cards.get(i).getTypes() == 2){
                selectedCards.add(cards.get(i));
            }
        }
        return selectedCards;
    }

    @Override
    public List<Card> getArticleCards() {
        List<Card> cards = cardMapper.getCards();
        List<Card> selectedCards = new ArrayList<>();
        for(int i = 0; i < cards.size(); i++){
            if(cards.get(i).getTypes() == 3){
                selectedCards.add(cards.get(i));
            }
        }
        return selectedCards;
    }

    @Override
    public List<Card> getCardsByCategory(String id) {
        String[] strings = id.split("_");
        String[][] categories = new String[][]{{"中华文化"},
                {"中华历史", "起源", "成就", "英雄"},
                {"语言与文学", "语言", "文字", "诗词", "对联", "灯谜", "小说", "著作", "寓言"},
                {"思想与信仰", "道教", "易经", "儒学", "百家", "宗教", "家教"},
                {"科学与技术", "四大发明", "科技成就", "中医"},
                {"体育与竞技", "武术", "龙舟", "象棋", "围棋"},
                {"节日与习俗", "历法", "节日", "节气", "婚丧习俗"},
                {"饮食文化", "四大菜系", "酒文化", "茶文化"},
                {"民族文化", "服装", "巴蜀文化", "巫蛊"},
                {"艺术", "戏曲", "乐器", "手工艺", "书法", "美术", "建筑"},
                {"其它", "常识"}};
        String category = categories[Integer.parseInt(strings[0])][Integer.parseInt(strings[1])];
        List<Card> cards = cardMapper.getCards();
        List<Card> selectedCards = new ArrayList<>();
        for(int i = 0; i < cards.size(); i++){
            String[] temp = cards.get(i).getClasses().split("_");
            for(int j = 0; j < temp.length; j++){
                if (temp[j].equals(category)){
                    selectedCards.add(cards.get(i));
                }
            }
        }
        if (selectedCards.size() == 0) return cards;
        return selectedCards;
    }

    @Override
    public List<Card> getUserCards(int id) {
        return cardMapper.getUserCards(id);
    }

    @Override
    public List<Card> getUserLikedCards(int id) {
        return cardMapper.getUserLikedCards(id);
    }

    @Override
    public List<Card> getUserCommentedCards(int id) {
        return cardMapper.getUserCommentedCards(id);
    }

    @Override
    public List<Card> searchCards(String query) {
        List<Card> cards = cardMapper.getCards();
        List<Card> searchedCards = new ArrayList<>();
        for(int i = 0; i < cards.size(); i++){
            String[] temp = cards.get(i).getClasses().split("_");
            for(int j = 0; j < temp.length; j++){
                if (temp[j].equals(query)){
                    searchedCards.add(cards.get(i));
                }
            }
        }
        return searchedCards;
    }

    @Override
    public Video getVideoById(int id) {
        return cardMapper.getVideo(id);
    }

    @Override
    public Audio getAudioById(int id) {
        return cardMapper.getAudio(id);
    }

    @Override
    public List<Photo> getPhotosById(int id) {
        return cardMapper.getPhotos(id);
    }

    @Override
    public Article getArticleById(int id) {
        return cardMapper.getArticle(id);
    }

    @Override
    public void likeCard(int user_id, int card_id) {
        Integer likeID = UUID.randomUUID().toString().hashCode();
        Like like = new Like();
        like.setLike_id(likeID);
        like.setUser_id(user_id);
        like.setLiked_id(card_id);
        cardMapper.likeCard(like);
        cardMapper.updateUserLike(user_id);
    }

    @Override
    public boolean getIsLike(int user_id, int card_id) {
        List<Like> cards = cardMapper.getLikedCard(user_id);
        for(int i = 0; i < cards.size(); i++){
            if(cards.get(i).getLiked_id() == card_id){
                return true;
            }
        }
        return false;
    }

    @Override
    public void commentCard(int user_id, int card_id, String content) {
        Integer commentID = UUID.randomUUID().toString().hashCode();
        Comment commentEntity = new Comment();
        commentEntity.setComment_id(commentID);
        commentEntity.setCard_id(card_id);
        commentEntity.setUser_id(user_id);
        commentEntity.setContent(content);
        cardMapper.commentCard(commentEntity);
        cardMapper.updateUserComment(user_id);
    }

    @Override
    public void passCard(int id) {
        cardMapper.updateCardVerify(id);
    }

    @Override
    public void notPassCard(int id) {
        cardMapper.deleteCardById(id);
    }

    @Override
    public List<Comment> getCommentsById(int id) {
        return cardMapper.getCommentsById(id);
    }
}
