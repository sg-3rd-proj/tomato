package com.trifling.things.repository;

import com.trifling.things.dto.response.MovieDetailResponseDTO;
import com.trifling.things.dto.page.Search;
import com.trifling.things.entity.Movie;
import com.trifling.things.entity.MovieImg;
import com.trifling.things.entity.Rate;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface MovieMapper {

    // 영화 등록하기(관리자)

    // 영화 삭제하기(관리자)

    // 영화 전체 조회
    public List<Movie> movieList(Search page);

    // 영화 상세 조회
    public Movie movieFindOne(int movieNum);

    // 영화 점수 갱신
    public boolean movieScoreRenew(int movieNum);

    public int count(Search search);

    public List<MovieImg> targetMovieImg(int movieNum);

    public List<Movie> mainTopTenList(String type);

    public int checkLike(@Param("movieNum")int movieNum, @Param("userNum")int userNum);

    public int insertMovieInfo(Movie movie);

    public int insertMovieImg(MovieImg img);

    public int maxMovieNum();

}
