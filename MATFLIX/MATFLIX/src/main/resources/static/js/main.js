import $ from 'jquery';

$(document).ready(function() {
    // 이미지 로드 오류 처리
    $(".recipe-image img").on("error", function() {
        $(this).hide();
        $(this).parent().append('<div class="no-image"><i class="fas fa-utensils"></i></div>');
    });
    
    // 카테고리 섹션 애니메이션
    animateSections();
    
    // 스크롤 이벤트
    $(window).scroll(function() {
        animateSections();
    });
    
    // 히어로 섹션 애니메이션
    $(".hero-content").css({
        'opacity': '0',
        'transform': 'translateY(30px)'
    }).animate({
        'opacity': '1',
        'transform': 'translateY(0)'
    }, 800);
});

// 섹션 애니메이션 함수
function animateSections() {
    $(".category-section").each(function() {
        const sectionPos = $(this).offset().top;
        const topOfWindow = $(window).scrollTop();
        const windowHeight = $(window).height();
        
        if (sectionPos < topOfWindow + windowHeight - 100) {
            if (!$(this).hasClass('animated')) {
                $(this).addClass('animated');
                
                // 섹션 제목 애니메이션
                $(this).find(".section-title").css({
                    'opacity': '0',
                    'transform': 'translateY(20px)'
                }).animate({
                    'opacity': '1',
                    'transform': 'translateY(0)'
                }, 600);
                
                // 레시피 아이템 순차 애니메이션
                $(this).find(".recipe-item").each(function(i) {
                    $(this).css({
                        'opacity': '0',
                        'transform': 'translateY(20px)'
                    }).delay(i * 100).animate({
                        'opacity': '1',
                        'transform': 'translateY(0)'
                    }, 500);
                });
            }
        }
    });
}

// 레시피 슬라이더 (필요시 구현)
function initRecipeSliders() {
    // 슬라이더 기능이 필요한 경우 여기에 구현
    // 예: Slick 슬라이더 등의 라이브러리 활용
}