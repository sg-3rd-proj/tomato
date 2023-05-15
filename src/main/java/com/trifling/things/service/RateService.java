package com.trifling.things.service;

import com.trifling.things.dto.page.Page;
import com.trifling.things.dto.page.PageMaker;
import com.trifling.things.dto.request.RateModifyRequestDTO;
import com.trifling.things.dto.request.RatePostRequestDTO;
import com.trifling.things.dto.response.RateListResponseDTO;
import com.trifling.things.dto.response.RateResponseDTO;
import com.trifling.things.entity.Rate;
import com.trifling.things.repository.RateMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;


// RESTful 방식으로써 사실상 return이 getRateList여야 한다
@Service
@RequiredArgsConstructor
public class RateService {

    private final RateMapper rateMapper;

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


    // 리턴 타입 entity
    public RateListResponseDTO rateWrite(RatePostRequestDTO dto) {
        Rate rate = dto.toEntity();
        // dto를 entity로 변환해줘야댐
        boolean flag = rateMapper.rateWrite(rate);
        // 예외처리는 어떤데?

        return getRateList("movie", dto.getMovieNum(), new Page(1,10));
        // 엔티티 리턴해줘야 RESTful 적용 가능 바로 보여져야됨
    }

    // 평가번호로 평가 하나 찾기
//    public Rate rateFindOne(int rateNum) {
//        Rate rate = rateMapper.rateFindOne(rateNum);
//
//        return rate;
//    }

    @Transactional
    public RateListResponseDTO rateDelete(int rateNum) {

        int movieNum = rateMapper.rateFindOne(rateNum).getMovieNum();
        rateMapper.rateDelete(rateNum);

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

        return getRateList("movie",dto.getRateNum(),new Page(1,10));
    }


}
