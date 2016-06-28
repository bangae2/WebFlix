<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: bangae1
  Date: 2016-06-21
  Time: 오후 4:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- start Main Content (Media Page Section) -->
<script>
    $(document).ready(function() {

        var interval = setInterval(duration, 1000);

        function duration() {
            $('#play_time').text(Math.floor($('video')[0].duration / 60) + '분');
            clearInterval(interval);
        }

        $('#watchVideo').click(function() {
            $('#tm-media-section').css('display', 'none');
            $('#video-player').css('display', 'block');
            var currentTime = localStorage.getItem($('#title3').text());
            $('video')[0].currentTime = currentTime;
//            video.play();
        })

        $('.play-back').click(function() {
            $('#tm-media-section').css('display', 'block');
            $('#video-player').css('display', 'none');
            var currentTime = video.currentTime;
            localStorage.setItem($('#title3').text(), currentTime);
            video.pause();
        })

        $('#favourite').click(function() {
            $.ajax({
                url:'/video_favourite',
                type:'post',
                data:$('#favourite_form').serialize(),
                success:function(data) {
                    if(data == 1) {
                        $('.uk-icon-heart').css('color', 'red');
                    } else {
                        $('.uk-icon-heart').css('color', '');
                    }
                }, error:function(xhr, status, error) {
                    alert(error);
                }
            })
        })
    })
</script>
<div id="video-player">
    <i class="fa fa-chevron-circle-left fa-3x play-back" aria-hidden="true" ></i>
    <video id="video" width="100%" controls="controls">
        <source src="${pageContext.request.contextPath}${video.file_path}${video.file_name}" type="video/mp4"/>
    </video>
</div>
<div id="tm-media-section" class="uk-block uk-block-small">

    <div class="uk-container uk-container-center uk-width-8-10">
        <div class="media-container  uk-container-center">
            <a class="uk-button uk-button-large uk-button-link uk-text-muted" href="${pageContext.request.contextPath}/"><i class=" uk-icon-arrow-left uk-margin-small-right"></i> Back</a>
        </div>

        <div class="uk-grid">
            <div class="uk-width-medium-3-10">
                <div  class="media-cover">
                    <img src="${pageContext.request.contextPath}${video.file_path}thumbnail/${video.thumbnail}" alt="Image" class="uk-scrollspy-inview uk-animation-fade"/>
                </div>
                <button id="watchVideo" class="uk-button uk-button-primary uk-button-large uk-width-1-1 uk-margin-top"><i class="uk-icon-television uk-margin-small-right"></i> Watch Now</button>
                <form id="favourite_form">
                    <input type="hidden" name="video_seq" value="${video.video_seq}"/>
                    <input type="hidden" name="id" value="<sec:authentication property="principal.id"/>"/>
                    <button type="button" id="favourite" class="uk-button uk-button-link uk-text-muted uk-button-large uk-width-1-1 uk-margin-top" href="login.html"><i class="uk-icon-heart uk-margin-small-right" style="<c:if test='${video_favourites.video_seq != null}'>color:red;</c:if>"/> </i> 즐겨찾기 추가</button>
                </form>
            </div>
            <div class="uk-width-medium-7-10">
                <div class="">
                    <ul class="uk-tab uk-tab-grid " data-uk-switcher="{connect:'#media-tabs'}">
                        <li class="uk-width-medium-1-3 uk-active"><a href="#">Description</a></li>
                        <li class="uk-width-medium-1-3"><a href="#">Reviews</a></li>
                        <li class="uk-width-medium-1-3"><a href="#">Trailer</a></li>
                        <li class="uk-tab-responsive uk-active uk-hidden" aria-haspopup="true" aria-expanded="false"><a>Active</a><div class="uk-dropdown uk-dropdown-small uk-dropdown-up"><ul class="uk-nav uk-nav-dropdown"></ul><div></div></div></li></ul>
                </div>

                <ul id="media-tabs" class="uk-switcher">

                    <!--     start Tab Panel 1 (Reviews Sections) -->
                    <li>
                        <h2 id="title3" class="uk-text-contrast uk-margin-large-top"><%--${video.title3}--%>
                            <span class="rating uk-margin-small-left uk-h4 uk-text-warning">
                                <c:set var="rate" value="0"/>
                                <c:if test="${rate == 0}">
                                    <i class="uk-icon-star-o"></i>
                                    <i class="uk-icon-star-o"></i>
                                    <i class="uk-icon-star-o"></i>
                                    <i class="uk-icon-star-o"></i>
                                    <i class="uk-icon-star-o"></i>
                                </c:if>
                                <c:if test="${rate == 1}">
                                    <i class="uk-icon-star-half-o"></i>
                                    <i class="uk-icon-star-o"></i>
                                    <i class="uk-icon-star-o"></i>
                                    <i class="uk-icon-star-o"></i>
                                    <i class="uk-icon-star-o"></i>
                                </c:if>
                                <c:if test="${rate == 2}">
                                    <i class="uk-icon-star"></i>
                                    <i class="uk-icon-star-o"></i>
                                    <i class="uk-icon-star-o"></i>
                                    <i class="uk-icon-star-o"></i>
                                    <i class="uk-icon-star-o"></i>
                                </c:if>
                                <c:if test="${rate == 3}">
                                    <i class="uk-icon-star"></i>
                                    <i class="uk-icon-star-half-o"></i>
                                    <i class="uk-icon-star-o"></i>
                                    <i class="uk-icon-star-o"></i>
                                    <i class="uk-icon-star-o"></i>
                                </c:if>
                                <c:if test="${rate == 4}">
                                    <i class="uk-icon-star"></i>
                                    <i class="uk-icon-star"></i>
                                    <i class="uk-icon-star-o"></i>
                                    <i class="uk-icon-star-o"></i>
                                    <i class="uk-icon-star-o"></i>
                                </c:if>
                                <c:if test="${rate == 5}">
                                    <i class="uk-icon-star"></i>
                                    <i class="uk-icon-star"></i>
                                    <i class="uk-icon-star-half-o"></i>
                                    <i class="uk-icon-star-o"></i>
                                    <i class="uk-icon-star-o"></i>
                                </c:if>
                                <c:if test="${rate == 6}">
                                    <i class="uk-icon-star-"></i>
                                    <i class="uk-icon-star"></i>
                                    <i class="uk-icon-star"></i>
                                    <i class="uk-icon-star-o"></i>
                                    <i class="uk-icon-star-o"></i>
                                </c:if>
                                <c:if test="${rate == 7}">
                                    <i class="uk-icon-star-"></i>
                                    <i class="uk-icon-star"></i>
                                    <i class="uk-icon-star"></i>
                                    <i class="uk-icon-star-half-o"></i>
                                    <i class="uk-icon-star-o"></i>
                                </c:if>
                                <c:if test="${rate == 8}">
                                    <i class="uk-icon-star-"></i>
                                    <i class="uk-icon-star"></i>
                                    <i class="uk-icon-star"></i>
                                    <i class="uk-icon-star"></i>
                                    <i class="uk-icon-star-o"></i>
                                </c:if>
                                <c:if test="${rate == 9}">
                                    <i class="uk-icon-star-"></i>
                                    <i class="uk-icon-star"></i>
                                    <i class="uk-icon-star"></i>
                                    <i class="uk-icon-star"></i>
                                    <i class="uk-icon-star-half-o"></i>
                                </c:if>
                                <c:if test="${rate == 10}">
                                    <i class="uk-icon-star-"></i>
                                    <i class="uk-icon-star"></i>
                                    <i class="uk-icon-star"></i>
                                    <i class="uk-icon-star"></i>
                                    <i class="uk-icon-star"></i>
                                </c:if>
                            </span>
                        </h2>
                        <ul class="uk-subnav uk-subnav-line">
                            <li ><i class="uk-icon-star uk-margin-small-right"></i> <%--${video.star}--%></li>
                            <li id="play_time"><i class="uk-icon-clock-o uk-margin-small-right"></i> </li>
                            <li>    <%--${video.start_date}--%></li>
                        </ul>
                        <hr/>
                        <p class="uk-text-muted uk-h4"><%--${video.story}--%></p>
                        <dl class="uk-description-list-horizontal uk-margin-top">
                            <dt>Starring</dt>
                            <dd><ul class="uk-subnav ">
                                <li><a href="#"><%--${video.actor}--%></a></li>
                            </ul></dd>
                            <dt>Genres</dt>
                            <dd><ul class="uk-subnav ">
                                <li><a href="#"><%--${video.genre}--%></a></li>
                            </ul></dd>
                            <dt>Countries</dt>
                            <dd><ul class="uk-subnav ">
                                <li><a href="#"><%--${video.country}--%></a></li>
                            </ul></dd>
                        </dl>

                    </li>

                    <!--    ./ Tab Panel 1  -->

                    <!--     start Tab Panel 2  (Reviews Section) -->

                    <li>
                        <div class="uk-margin-small-top">
                            <h3 class="uk-text-contrast uk-margin-top">Post a Review</h3>
                            <div class="uk-alert uk-alert-warning" data-uk-alert="">
                                <a href="" class="uk-alert-close uk-close"></a>
                                <p><i class="uk-icon-exclamation-triangle uk-margin-small-right "></i> Please <a class="uk-text-contrast" href="login.html"> Log in</a> or Sign up to post reviews quicker.</p>
                            </div>
                            <form class="uk-form uk-margin-bottom">
                                <div class="uk-form-row">
                                    <textarea class="uk-width-1-1" cols="30" rows="5" placeholder="Type your review here..."></textarea>
                                    <p class="uk-form-help-block">The <code>.uk-form-help-block</code> class creates an associated paragraph.</p>
                                </div>
                                <div class="uk-form-row">
                                    <a href="" class="uk-button uk-button-large uk-button-success uk-float-right">Post</a>
                                </div>
                            </form>
                        </div>

                        <div  class="uk-scrollable-box uk-responsive-width " data-simplebar-direction="vertical">
                            <ul class="uk-comment-list uk-margin-top" >
                                <li>
                                    <article class="uk-comment uk-panel uk-panel-space uk-panel-box-secondary">
                                        <header class="uk-comment-header">
                                            <img class="uk-comment-avatar uk-border-circle" src="${pageContext.request.contextPath}/resources/img/avatar3.jpg" width="50" height="50" alt=""/>
                                            <h4 class="uk-comment-title">@movielover</h4>
                                            <div class="uk-comment-meta">2 days ago </div>
                                        </header>
                                        <div class="uk-comment-body">
                                            <p>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.</p>
                                        </div>
                                    </article>
                                </li>
                                <li>
                                    <article class="uk-comment uk-panel uk-panel-space uk-panel-box-secondary">
                                        <header class="uk-comment-header">
                                            <img class="uk-comment-avatar uk-border-circle" src="${pageContext.request.contextPath}/resources/img/avatar1.jpg" width="50" height="50" alt=""/>
                                            <h4 class="uk-comment-title">@movielover</h4>
                                            <div class="uk-comment-meta">5 days ago </div>
                                        </header>
                                        <div class="uk-comment-body">
                                            <p>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.</p>
                                        </div>
                                    </article>
                                </li>
                                <li>
                                    <article class="uk-comment uk-panel uk-panel-space uk-panel-box-secondary">
                                        <header class="uk-comment-header">
                                            <img class="uk-comment-avatar uk-border-circle" src="${pageContext.request.contextPath}/resources/img/avatar4.svg" width="50" height="50" alt=""/>
                                            <h4 class="uk-comment-title">@movielover</h4>
                                            <div class="uk-comment-meta">23 days ago </div>
                                        </header>
                                        <div class="uk-comment-body">
                                            <p>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.</p>
                                        </div>
                                    </article>
                                </li>
                                <li>
                                    <article class="uk-comment uk-panel uk-panel-space uk-panel-box-secondary">
                                        <header class="uk-comment-header">
                                            <img class="uk-comment-avatar uk-border-circle" src="${pageContext.request.contextPath}/resources/img/avatar3.jpg" width="50" height="50" alt=""/>
                                            <h4 class="uk-comment-title">@movielover</h4>
                                            <div class="uk-comment-meta">7 days ago </div>
                                        </header>
                                        <div class="uk-comment-body">
                                            <p>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.</p>
                                        </div>
                                    </article>
                                </li>
                                <li>
                                    <article class="uk-comment uk-panel uk-panel-space uk-panel-box-secondary">
                                        <header class="uk-comment-header">
                                            <img class="uk-comment-avatar uk-border-circle" src="${pageContext.request.contextPath}/resources/img/avatar2.jpg" width="50" height="50" alt=""/>
                                            <h4 class="uk-comment-title">@movielover</h4>
                                            <div class="uk-comment-meta">84 days ago </div>
                                        </header>
                                        <div class="uk-comment-body">
                                            <p>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.</p>
                                        </div>
                                    </article>
                                </li>
                                <li>
                                    <article class="uk-comment uk-panel uk-panel-space uk-panel-box-secondary">
                                        <header class="uk-comment-header">
                                            <img class="uk-comment-avatar uk-border-circle" src="${pageContext.request.contextPath}/resources/img/avatar1.jpg" width="50" height="50" alt=""/>
                                            <h4 class="uk-comment-title">@movielover</h4>
                                            <div class="uk-comment-meta">3 days ago </div>
                                        </header>
                                        <div class="uk-comment-body">
                                            <p>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.</p>
                                        </div>
                                    </article>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <!--     ./ Tab Panel 2  -->


                    <!--     start Tab Panel 3 (Trailer Section)  -->

                    <li>
                        <div class="uk-cover uk-margin-top" style="height: 400px;">
                            <%--<iframe data-uk-cover="data-uk-cover" src="" width="560" height="315" frameborder="0" allowfullscreen=""></iframe>--%>
                        </div>
                    </li>

                    <!--     ./ Tab Panel 3  -->


                </ul>
            </div>
        </div>
    </div>
</div>

<!-- ./ Main Content (Media Page Section) -->


<!--     Start Similar Media Section  -->

<div class="uk-block ">
    <div class="uk-container-center uk-container uk-margin-large-bottom">
        <h3 class="uk-margin-large-bottom uk-text-contrast">관련영상</h3>
        <div class="uk-margin" data-uk-slideset="{small: 2, medium: 4, large: 6}">
            <div class="uk-slidenav-position uk-margin">
                <ul class="uk-slideset uk-grid uk-flex-center">
                    <%--<c:forEach items="${same_video}" var="video">--%>
                        <%--<li>--%>
                            <%--<a href="${pageContext.request.contextPath}/media/${video.video_seq}"><img src="${pageContext.request.contextPath}${video.file_path}thumbnail/${video.thumbnail}" width="600" height="400" alt=""/>--%>
                                <%--<span class="uk-preview-title">${video.title3}</span>--%>
                            <%--</a>--%>
                        <%--</li>--%>
                    <%--</c:forEach>--%>
                </ul>
                <a href="#" class="uk-slidenav uk-slidenav-contrast uk-slidenav-previous" data-uk-slideset-item="previous"></a>
                <a href="#" class="uk-slidenav uk-slidenav-next uk-slidenav-contrast" data-uk-slideset-item="next"></a>
            </div>
            <ul class="uk-slideset-nav uk-dotnav uk-dotnav-contrast uk-flex-center uk-margin-top"></ul>
        </div>
    </div>
</div>

<!--     ./ Similar Media Section  -->
