package com.good_ghost.hua_culture.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data//get set to_string equals
@Builder//.build
@NoArgsConstructor
@AllArgsConstructor
public class Card {
    int card_id;
    int user_id;
    String intro;
    int types;
    String classes;
    int video_id;
    int audio_id;
    int photo_id;
    int article_id;
    String source;
    boolean is_checked;
    int checker;
    int hot;
    int like_num;
    int comment_num;
    Date time;
}
