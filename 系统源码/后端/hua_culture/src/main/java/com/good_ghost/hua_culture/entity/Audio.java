package com.good_ghost.hua_culture.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data//get set to_string equals
@Builder//.build
@NoArgsConstructor
@AllArgsConstructor
public class Audio {
    int audio_id;
    int group_id;
    int username;
    String url;
}
