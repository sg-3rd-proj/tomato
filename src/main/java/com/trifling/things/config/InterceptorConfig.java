package com.trifling.things.config;

import com.trifling.things.interceptor.AfterLoginInterceptor;
import com.trifling.things.interceptor.RateInterceptor;
import com.trifling.things.interceptor.UserInterceptor;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

// 다양한 인터셉터에 관련 설정을 등록하는 클래스
@Configuration
@RequiredArgsConstructor
public class InterceptorConfig
        implements WebMvcConfigurer {

    private final RateInterceptor replyInterceptor;
    private  final AfterLoginInterceptor afterLoginInterceptor;
    private final UserInterceptor userInterceptor;
    // 인터셉터 설정 등록
    @Override
    public void addInterceptors(InterceptorRegistry registry) {

        // 게시판 인터셉터 설정
        registry.addInterceptor(replyInterceptor)
                .addPathPatterns("/api/replies/*") // 어떤 경로에서 인터셉터를 실행할 것인가
//                .excludePathPatterns("/board/list", "/board/detail") // 인터셉터를 실행하지 않을 경로
        ;

        // 로그인 후처리 인터셉터 설정
        registry.addInterceptor(afterLoginInterceptor)
                .addPathPatterns("/user/sign-in","/user/sign-up")
        ;

        // 로그인 후처리 인터셉터 설정
        registry.addInterceptor(userInterceptor)
                .addPathPatterns("/user/*")
                .excludePathPatterns("/user/sign-up", "/user/login", "/user/sign-in", "/user/check") // 인터셉터를 실행하지 않을 경로
        ;

    }


}
