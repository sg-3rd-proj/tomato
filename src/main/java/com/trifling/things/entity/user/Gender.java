package com.trifling.things.entity.user;

public enum Gender {
    MALE("남성"),
    FEMALE("여성"),
    UNKNOWN("알 수 없음");

    private final String value;

    Gender(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}

