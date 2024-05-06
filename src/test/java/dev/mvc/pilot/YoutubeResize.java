package dev.mvc.pilot;

public class YoutubeResize {

  public static void main(String[] args) {
    String str = "<iframe width=\"1019\" height=\"573\" src=\"https://www.youtube.com/embed/Aubh5KOpz-4\" title=\"교보문고에서 가장 잘나가는 일본 추리소설 베스트셀러 10위부터 1위까지 소개해드려요?\" frameborder=\"0\" allow=\"accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share\" allowfullscreen></iframe>";
    
//    <iframe width="1584" height="620" src="https://www.youtube.com/embed/Aubh5KOpz-4" title="교보문고에서 가장 잘나가는 일본 추리소설 베스트셀러 10위부터 1위까지 소개해드려요?" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
//    <iframe width="611" height="343" src="https://www.youtube.com/embed/Aubh5KOpz-4" title="교보문고에서 가장 잘나가는 일본 추리소설 베스트셀러 10위부터 1위까지 소개해드려요?" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe

    // 1. 이미지 축소 비율을 찾기
    // width를 640 맞추고 height는 비례하여 자동 조절 되도록 할 것.
    System.out.println(1019/640.0);
    System.out.println(1584/640.0);

    System.out.println(640.0/1019);
    System.out.println(640.0/1584);
    
    System.out.println("--------------------------------------");
    double rate = 640.0/1019; // 가로 세로 비율 산출하여 비율을 가로, 세로 크기에 곱하기하면 적용할 크기가 산출됨.
    System.out.println((int)(1019 * rate)); // 비율을 산출하여 원래의 크기에 곱하면 적용할 크기가 산출됨.
    System.out.println((int)(573 * rate));
    System.out.println("--------------------------------------");
    rate = 640.0/1584;
    System.out.println((int)(1584 * rate));
    System.out.println((int)(620 * rate));
    
    // 2. 문자열 " ->' 변경하기
    str = str.replaceAll("\"", "'"); // " -> '
    System.out.println(str);
    
    // 3. 문자열 분할
    String[] tokens = str.split(" "); // 공백으로 문자열 분리
    System.out.println(tokens[1]);
    System.out.println(tokens[2]);
    
    // 4. 정수 추출 
    int width = Integer.parseInt(tokens[1].replaceAll("[^0-9]", "")); // 정수가 아닌 문자열을 삭제함.
    int height = Integer.parseInt(tokens[2].replaceAll("[^0-9]", ""));
    
    System.out.println("-> width: " + width);
    System.out.println("-> height: " + height);

    // 5. 크기 계산
    double rateper = 640.0/width;
    width = (int)(width * rateper);
    height = (int)(height * rateper);
    
    System.out.println("-> width: " + width);
    System.out.println("-> height: " + height);
    
    // 6. 문자열 생성
    tokens[1] = String.format("width='%d'", width); // 형식에 맞는 문자열 생성, %d: 정수
    tokens[2] = String.format("height='%d'", height);
    
    System.out.println(tokens[1]);
    System.out.println(tokens[2]);
    
    // 7. 문자열 결합
    StringBuffer sb = new StringBuffer();
    for(String token : tokens) {
      sb.append(" " + token);
    }
    System.out.println("--------------------------------------");
    System.out.println(sb.toString().trim());
    
  }

}
