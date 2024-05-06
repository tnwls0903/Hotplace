package dev.mvc.pilot;

import dev.mvc.tool.Tool;

public class Youtube {

  public static void main(String[] args) {
    String url = "<iframe width=\"640\" height=\"359\" src=\"https://www.youtube.com/embed/I2KnLOCYR3o\" title=\"【무서운이야기 실화】 선의를 베풀다가 벌어진 충격 실화 리어카 할머니 사건ㅣ마계남님 사연ㅣ돌비공포라디오ㅣ괴담ㅣ미스테리 인터뷰ㅣ시청자 사연ㅣ공포툰ㅣ오싹툰ㅣ공포썰\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share\" referrerpolicy=\"strict-origin-when-cross-origin\" allowfullscreen></iframe>";
    Tool.youtubeResize(url, 640);

  }

}
