package com.kh.springProject.common.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class GoogleInfResponse {
    private String sub;
    private String name;
    private String givenName;
    private String familyName;
    private String picture;
    private String email;
    private String emailVerified;
    private String gender;
    private String birthDate;
    private String locale;
}
