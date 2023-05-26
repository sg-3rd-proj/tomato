package com.trifling.things.service;

import com.trifling.things.dto.page.Page;
import com.trifling.things.dto.page.PageMaker;
import com.trifling.things.dto.request.RateModifyRequestDTO;
import com.trifling.things.dto.request.RatePostRequestDTO;
import com.trifling.things.dto.response.LoginUserResponseDTO;
import com.trifling.things.dto.response.RateListResponseDTO;
import com.trifling.things.dto.response.RateResponseDTO;
import com.trifling.things.dto.response.ScoreResponseDTO;
import com.trifling.things.entity.Rate;
import com.trifling.things.repository.RateMapper;
import com.trifling.things.util.LoginUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;


// RESTful 방식으로써 사실상 return이 getRateList여야 한다
@Service
@RequiredArgsConstructor
@Slf4j
public class RateService {

    private final RateMapper rateMapper;
    private final MovieService movieService;

    public RateListResponseDTO getRateList(String type, int target, Page page) {

        List<RateResponseDTO> rates = rateMapper.rateList(type, target, page).stream().
                map(RateResponseDTO::new).collect(Collectors.toList());

        int count = rateMapper.countScore(target);

        return RateListResponseDTO.builder()
                .count(count)
                .pageInfo(new PageMaker(page, count))
                .rates(rates)
                .build();
    }


    public RateListResponseDTO rateWrite(RatePostRequestDTO dto, HttpSession session) {
        // dto를 entity로 변환해줘야댐
        Rate rate = dto.toEntity();

        LoginUserResponseDTO user = (LoginUserResponseDTO)session.getAttribute(LoginUtil.LOGIN_KEY);
        rate.setUserId(user.getSuserid());
        rateMapper.pointPlus(dto.getUserNum());
        boolean flag = rateMapper.rateWrite(rate);
        movieService.movieScoreRenew(dto.getMovieNum());
        return getRateList("movie", dto.getMovieNum(), new Page(1,10));
        // 엔티티 리턴해줘야 RESTful 적용 가능 바로 보여져야됨
    }

    // 평가번호로 평가 하나 찾기
    public Rate rateFindOne(int rateNum) {
        return rateMapper.rateFindOne(rateNum);
    }


    // 평가 등록 여부 검사 기능
    public boolean insertBeforeCheck(int movieNum, HttpSession session) {

        LoginUserResponseDTO user = (LoginUserResponseDTO)session.getAttribute(LoginUtil.LOGIN_KEY);

        // 현재 세션의 유저번호
        int susernum = user.getSusernum();

        return rateMapper.insertBeforeCheck(movieNum, susernum) == 1;
    }

    @Transactional
    public RateListResponseDTO rateDelete(int rateNum) {

        Rate rate = rateMapper.rateFindOne(rateNum);
        int movieNum = rate.getMovieNum();
        boolean flag = rateMapper.rateDelete(rateNum);
//        log.info("삭제 서비스 {} ",rateNum);
        rateMapper.pointMinus(rate.getUserNum());
        return getRateList("movie", movieNum, new Page(1,10));
    }

    public RateListResponseDTO rateModify(RateModifyRequestDTO dto) {
        Rate rate = Rate.builder()
                .rateScore(dto.getRateScore())
                .rateReview(dto.getRateReview())
                .rateNum(dto.getRateNum())
                .rateDate(LocalDateTime.now())
                .build();


        boolean flag = rateMapper.rateModify(rate);
        log.info("플래그 : {}", flag);

        return getRateList("movie",dto.getRateNum(),new Page(1,10));
    }


    public boolean insertLike(int movieNum, int userNum) {

        return rateMapper.insertLike(movieNum, userNum) == 1;
    }

    public boolean deleteLike(int movieNum, int userNum) {

        return rateMapper.deleteLike(movieNum, userNum) == 1;
    }

    public ScoreResponseDTO totalMovieScore(int movieNum) {
        return rateMapper.totalMovieScore(movieNum);
    }

}