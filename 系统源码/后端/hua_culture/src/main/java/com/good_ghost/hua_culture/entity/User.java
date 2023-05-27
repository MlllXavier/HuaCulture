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
public class User { //PO
    private int username;
    private String password;
    String name;
    String photo;
    String intro;
    String classes;
    int like_num;
    int comment_num;
    boolean is_verifiable;
    Date time;
}