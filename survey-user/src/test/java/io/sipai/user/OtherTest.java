package io.sipai.user;

import org.junit.Test;

import java.time.Instant;
import java.time.LocalDateTime;

public class OtherTest {

    @Test
    public void  test1(){

        System.out.println(Instant.now().toString());
        LocalDateTime localDateTime = LocalDateTime.now();
        LocalDateTime l = LocalDateTime.parse("2019-01-01T23:25:00"); // .plusDays(-1);
        System.out.println(System.currentTimeMillis());
    }


}
