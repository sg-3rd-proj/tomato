<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>


<head>
    <title>EATINGAPPLE</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="/assets/css/style.css" type="text/css" media="all" />
    <link rel="stylesheet" href="/assets/css/detail.css" type="text/css" media="all" />
    <link rel="stylesheet" href="/assets/css/create-rate-modal.css" type="text/css" media="all" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous">
    </script>

</head>

<body>

    <!-- START PAGE SOURCE -->
    <div id="shell">

        <!-- rate-modal  -->
        <!-- <%@ include file="../include/create-rate-modal.jsp" %> -->
        <div id="myModal" class="modal">
            <div class="modal-contents">
                <form method="POST" action="/submit">
                    <div class="modal-top-box">
                        <div class="modal-top-rate-icon-box">
                            <img src="/assets/img/xapple.png" alt="#" id="modal-rate-icon">
                        </div>
                        <div class="modal-top-rate-input-box">
                            <div class="modal-bottom-movie-title-box">
                                <span class="modal-movie-title">${detail.title}</span>
                            </div>
                            <div class="rating">
                                <input type="radio" id="star5" name="rating" value="5">
                                <label for="star5"></label>
                                <input type="radio" id="star4" name="rating" value="4">
                                <label for="star4"></label>
                                <input type="radio" id="star3" name="rating" value="3">
                                <label for="star3"></label>
                                <input type="radio" id="star2" name="rating" value="2">
                                <label for="star2"></label>
                                <input type="radio" id="star1" name="rating" value="1">
                                <label for="star1"></label>
                            </div>

                        </div>

                        <div class="modal-tot-close-button-box">
                            <span class="close">&times;</span>
                        </div>
                    </div>
                    <div class="modal-middle-box">
                        <div class="modal-middle-rate-content-box">
                            <textarea name="modal-content" id="modal-content" class="rate-content" cols="30"
                                rows="10"></textarea>

                        </div>
                    </div>
                    <div class="modal-bottom-box">
                        <div class="modal-bottom-left-box">

                            <div class="modal-bottom-writer-info-box">
                                <div id="user-num" class="modal-bottom-writer-profile-box" data-un="${login.susernum}">
                                    <c:if test="${login.sprofileimage != null}">
                                        <img src="${login.sprofileimage}" alt="프사">
                                    </c:if>
                                    <c:if test="${login.sprofileimage == null}">
                                        <img src="/assets/img/no-profile.png" alt="X">
                                    </c:if>

                                </div>
                                <div class="modal-bottom-writer-id-score-box">
                                    <div class="modal-bottom-writer-id-box">
                                        <span id="rate-writer">${login.suserid}</span>
                                    </div>
                                </div>
                                <div class="modal-bottom-writer-score-icon-box">
                                    <c:if test="${login.susergrade == 'BASIC'}">
                                        <img src="/assets/img/basicmedal.png" alt="#">
                                    </c:if>
                                    <c:if test="${login.susergrade == 'GOLD'}">
                                        <img src="/assets/img/goldmedal.png" alt="#">
                                    </c:if>
                                    <c:if test="${login.susergrade == 'VIP'}">
                                        <img src="/assets/img/quality.png" alt="#">
                                    </c:if>
                                </div>
                            </div>
                        </div>
                        <div class="modal-bottom-right-box">
                            <div class="modal-bottom-like-box">
                                <div class="modal-bottom-like-icon-box">
                                    <img src="/assets/img/welcome.gif" alt="welcome">
                                </div>
                            </div>
                            <div class="modal-bottom-save-button-box">
                                <button id="modal-save" type="button" class="modal-save-button">저 장</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <!-- rate-modal end -->

        <!-- header -->
        <%@ include file="../include/header.jsp" %>
        <div id="sub-navigation">
            <ul>
                <li>${detail.title}</li>
            </ul>
            <!--
            <div id="search">
                <form action="#" method="get" accept-charset="utf-8">
                    <label for="search-field">SEARCH</label>
                    <input type="text" name="search field" value="Enter search here" id="search-field"
                        class="blink search-field" />
                    <input type="submit" value="GO!" class="search-button" />
                </form>
            </div> -->
        </div>
    </div>
    <!-- header end -->





    <!-- main -->

    <div id="main" class="main-box">
        <div class="video-box">
            <div class="video-container">
                <c:forEach var="d" items="${detail.movieImgList}">
                    <c:if test="${d.imgName == 'youtube'}">
                        <iframe src="https://www.youtube.com/embed/${d.imgUrl}" frameborder="0"
                            allowfullscreen></iframe>
                    </c:if>
                </c:forEach>
            </div>
        </div>

        <div class="movie-detail-box">
            <div class="movie-detail-subname">
                <p><span>│</span> MOVIE INFO</p>
            </div>
            <div><span>${detail.info}</span>
            </div>
            <c:if test="${detail.age} == 1">
                <div>
                    <p>관람가: <span>전체 관람가</span></p>
                </div>
            </c:if>
            <c:if test="${detail.age gt 1 && detail.age lt 19}">
                <div>
                    <p>관람가: <span>${detail.age}세 이상</span></p>
                </div>
            </c:if>
            <c:if test="${detail.age == 19}">
                <div>
                    <p>관람가: <span>청소년 관람불가</span></p>
                </div>
            </c:if>

            <div>
                <p>장르: <span>${detail.genre}</span></p>
            </div>
            <div>
                <p>감독: <span>${detail.director}</span></p>
            </div>
            <div>
                <p>런타임: <span>${detail.runtime}</span></p>
            </div>
        </div>

        <div class="detail-post-rank-box">
            <div class="detail-post">
                <c:forEach var="d" items="${detail.movieImgList}">
                    <c:if test="${d.imgName == 'poster'}">
                        <img src="${d.imgUrl}" alt="#">
                    </c:if>
                </c:forEach>

            </div>
            <div class="detail-rank">
                <div class="rank-box-title">
                    <h2>영화 평가</h2>
                </div>
                <div class="rank-box-ranks">
                    <div class="rank">
                        <img src="/assets/img/apple.png" alt="#">
                        <h3>사소한 평가</h3>
                    </div>
                    <div class="rank-num-box">
                        <!-- <c:if test="${empty detail.score}">
                            <p class="score-p">0%</p>
                        </c:if>
                        <c:if test="${not empty detail.score}">
                            <p class="score-p">${detail.score}%</p>
                        </c:if> -->
                        <p class="score-p">${detail.score}%</p>
                    </div>
                    <!-- <div class="like">
                        <img src="/assets/img/like-httpswww.flaticon.com.png" alt="#">
                        <h3>LIKE</h3>
                    </div> -->
                    <div class="like-num-box" id="like-btn">
                        <c:if test="${login != null}">
                            <c:if test="${jjim == 0}">
                                <img class="like-img" src="/assets/img/blankheart.png" alt="빈하트">
                            </c:if>
                            <c:if test="${jjim == 1}">
                                <img class="like-img" src="/assets/img/filledheart.png" alt="풀하트">
                            </c:if>
                            <h3>LIKE</h3>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <div class="detail-rate-modal-buttons">
            <c:if test="${empty login}">
                <a class="btn btn-primary rate-box" id="rate-none-btn" href="/user/login">평가는 로그인 후 작성 가능합니다.</a>
            </c:if>
            <c:if test="${not empty login}">
                <div class="d-grid gap-2 col-6 mx-auto">
                    <button id="openModal" class="btn btn-primary modal-open" type="button">평가 남기기</button>
                </div>
                <!-- <button id="openModal">사소한평가 남기기</button> -->
            </c:if>
        </div>

        <div class="movie-detail-ranks-box">
            <div class="movie-detail-subname">
                <p><span>│</span> 평가 목록</p>
            </div>
            <div class="movie-detail-main-rank" id="rate-box">
                <!-- 평가 목록 생성 -->

            </div>
        </div>
        <ul class="pagination center-rate">
            <!-- 댓글 페이지 -->
        </ul>   
    <!--  MAIN END  -->
    </div>
    <!-- END PAGE SOURCE -->


    <script>
        const num = '${login.susernum}';

        const URL = '/rates';

        let mNum = '${detail.movieNum}';

        var $modal = document.getElementById("myModal");
        var $btn = document.getElementById("openModal");
        var $span = document.getElementsByClassName("close")[0];



        $btn.onclick = e => {

            fetch('/rates/' + mNum)
                .then(res => res.json())
                .then(check => {
                    if (!check) {
                        $modal.style.display = "block";
                    } else {
                        alert('평가는 한번만 남길 수 있으며 마이페이지에서 평가의 수정, 삭제가 가능합니다.');
                    }
                });

            // console.log('이거 왜 안나와 : ' + insertCheck);
        }

        $span.onclick = e => {
            $modal.style.display = "none";
        }

        let likeNum = +'${jjim}';

        // 좋아요 만들거야?
        const $likeBtn = document.getElementById('like-btn');
        const $likeImg = document.querySelector('.like-img');

        $likeBtn.onclick = e => {
            // console.log('이거맞지' + likeNum);
            if (e.target == $likeImg) {

                if (likeNum === 0) {

                    fetch(URL + '/in/' + mNum + '/' + num, {
                            method: 'POST'
                        })
                        .then(res => res.json())
                        .then(insertFlag => {
                            if (insertFlag) {
                                // console.log("찜");
                                $likeImg.src = '/assets/img/filledheart.png';
                                likeNum = 1;
                            }
                        });
                } else if (likeNum === 1) {

                    fetch(URL + '/out/' + mNum + '/' + num, {
                            method: 'DELETE'
                        })
                        .then(res => res.json())
                        .then(deleteFlag => {
                            if (deleteFlag) {
                                // console.log("삭제");
                                $likeImg.src = '/assets/img/blankheart.png';
                                likeNum = 0;
                            }
                        });
                }
            }

        };


        // 평가 목록 가져오기
        function getRateList(page = 1) {

            // @GetMapping("/{type}/contents/{target}/page/{page}")
            fetch(`\${URL}/movies/contents/\${mNum}/page/\${page}`)
                .then(res => res.json())
                .then(result => {
                    // console.log(result);
                    renderRateList(result);
                });
        }


        function renderRateList({
            count,
            pageInfo,
            rates
        }) {
            let tag = '';

            if (rates === null || rates.length === 0) {                
                tag += "<div class='speech-bubble-none center-position'>" +
                    "<div class='movie-detail-icon-text-box'>" +
                    "<div class='movie-detail-rate-icon'>" +
                    "<img src='/assets/img/apple.png' alt=''>" +
                    "</div>" +
                    "<div class='movie-detail-rate-text'>" +
                    "<span>" +
                    "<b> 첫 평가를 남겨주세요! </b>" +
                    "</span>" +
                    "</div>" +
                    "</div>" +
                    "<div class='none-write'><img src='/assets/img/write.png'></div>"
                "</div>";
            } else {                
                document.querySelector('.score-p').innerHTML = '0%';
                for (let rate of rates) {
                    const {
                        rateNum,
                        userNum,
                        movieNum,
                        rateReview,
                        rateScore,
                        rateDate,
                        userId,
                        profileImage
                    } = rate;
                    // console.log(i++);
                    let shortString = '';
                    if (rateReview.length > 50) {
                        shortString = (rateReview.substring(0, 50) + "...");
                    } else {
                        shortString = rateReview;
                    }

                    // <span class="full-review">펼쳐보기</span>

                    tag += `<div class="movie-detail-rate-containier" data-rn="\${rateNum}">
                                    <div class="speech-bubble">
                                        <div class="movie-detail-icon-text-box">
                                            <div class="movie-detail-rate-icon">
                                                <img src="/assets/img/apple.png" alt="">
                                                
                                            </div>
                                        </div>
                                        <div class="movie-detail-rate-text">
                                            <span>
                                                \${shortString}
                                            </span>
                                        </div>                                    
                                        <div class="movie-detail-rate-time-like-box">
                                            <div class="movie-detail-rate-time-box">
                                                <p>
                                                    <span> \${rateDate}</span> |<span> Rating: \${rateScore}/5</span>
                                                </p>
                                            </div>                                                                                                             
                                        </div>
                                    </div>
                                    <div class="movie-detail-rate-writer">`;
                    if (profileImage == null) {
                        tag += `<div class="writer-profile-img">
                                            <img src="/assets/img/cute.jpg">
                                        </div>`;
                    } else {
                        tag += `<div class="writer-profile-img">
                                            <img src="\${profileImage}">
                                        </div>`;
                    }

                    tag += `<div class="writer-name-score-box">
                                            <div class="writer-name">
                                                <span>
                                                    \${userId} 
                                                </span>
                                            </div>                                            
                                        </div>                             
                                    </div>
                                </div>`;

                }
            }

            document.getElementById('rate-box').innerHTML = tag;

            // console.log("제발요...");
            fetch(URL + '/total/' + mNum)
                .then(res => res.json())
                .then(secret => {
                    
                    let maxScore = 5 * secret.maxCount;
                    
                    
                    let percentScore = Math.floor((secret.totalScore / maxScore) * 100);

                    if (isNaN(percentScore)) {
                        // console.log('이건 스크립트' + maxScore);    
                        percentScore = 0;
                    } 
                    // console.log("맥스" + secret.maxCount + "  퍼센트 " + secret.totalScore);
                    const $pTag = document.querySelector('.score-p');
                    // console.log('이건 스크립트' + percentScore);
                    $pTag.innerHTML = percentScore + '%';
                });

                // 페이지 렌더링 해야되나...
                renderPage(pageInfo);

        }

        function renderPage({
            begin,
            end,
            prev,
            next,
            page,
            finalPage
        }) {

            let tag = "";

            //이전 버튼 만들기
            if (prev) {
                tag += "<li class='page-item'><a class='page-link page-active' href='" + (begin - 1) +
                    "'>이전</a></li>";
            }
            //페이지 번호 리스트 만들기
            for (let i = begin; i <= end; i++) {
                let active = '';
                if (page.pageNo === i) {
                    active = 'p-active';
                }

                tag += "<li class='page-item " + active + "'><a class='page-link page-custom' href='" + i +
                    "'>" + i + "</a></li>";
            }
            //다음 버튼 만들기
            if (next) {
                tag += "<li class='page-item'><a class='page-link page-active' href='" + (end + 1) +
                    "'>다음</a></li>";
            }

            // 페이지태그 렌더링
            const $pageUl = document.querySelector('.pagination');
            $pageUl.innerHTML = tag;

            // ul에 마지막페이지 번호 저장.
            $pageUl.dataset.fp = finalPage;

        }

        // 페이지 클릭 이벤트 핸들러
        function makePageButtonClickEvent() {
            // 페이지 버튼 클릭이벤트 처리
            const $pageUl = document.querySelector('.pagination');
            $pageUl.onclick = e => {
                if (!e.target.matches('.page-item a')) return;

                e.preventDefault(); // 태그의 기본 동작 중단

                // 누른 페이지 번호 가져오기
                const pageNum = e.target.getAttribute('href');
                // console.log(pageNum);

                // 페이지 번호에 맞는 목록 비동기 요청
                getRateList(pageNum);
            };
        }


        // function fullReview() {
        //     const $full = document.querySelector('.full-review');
        //     $full.onclick = e => {
        //         if( e.target.matches($full)){
        //             console.log('펼쳐보기');
        //         }
        //     }
        // }


        // 댓글 등록 기능
        function ratePostButton() {
            // 평가 등록 버튼
            const $postBtn = document.getElementById('modal-save');

            $postBtn.onclick = e => {

                // 유저 id
                const id = document.getElementById('rate-writer').textContent;
                // 유저 num
                const num = document.getElementById('user-num').dataset.un;
                // 평가 내용
                const review = document.querySelector('.rate-content').value;
                // 별점
                const $starScore = document.querySelectorAll('.rating input[type="radio"]');
                let selected = 0;

                // 별점 따라 사과 모양 바꿀까 말까?
                $starScore.forEach(target => {
                    if (target.checked) {
                        selected = +target.value;
                        // if (selected > 3) {
                        //     document.querySelector('.modal-top-rate-icon-box').closest;
                        // }
                    }
                });

                const payload = {             
                    userNum: num,
                    movieNum: mNum,
                    rateReview: review,
                    rateScore: selected,
                    userId: id
                };


                console.log(payload);

                const requestInfo = {
                    method: 'POST',
                    headers: {
                        'content-type': 'application/json'
                    },
                    body: JSON.stringify(payload)
                };
                if (selected < 1) {
                    alert('별점은 최소 1점 이상이어야 합니다.');
                } else {
                    fetch(`\${URL}/post`, requestInfo)
                        .then(res => {
                            if (res.status === 200) {
                                alert('평가가 정상적으로 등록되었습니다.');
                                // 등록 모달 닫기

                                $modal.style.display = "none";
                                // location.reload();
                                getRateList();
                                // $rw.value = '';
                            } else {
                                alert('댓글 등록에 실패함!');
                            }
                        });
                }
            }
        }



        (function () {

            getRateList();


            ratePostButton();

            makePageButtonClickEvent();
        })();
    </script>

    <!-- footer -->
    <%@ include file="../include/footer.jsp" %>
    <!-- footer end-->


</body>

</html>