package dev.mvc.resort_v1sbm3c;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import dev.mvc.contents.Contents;
import dev.mvc.tool.Tool;

@Configuration
public class WebMvcConfiguration implements WebMvcConfigurer{
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // Windows: path = "C:/kd/deploy/hotplace/contents/storage";
        // ▶ file:///C:/kd/deploy/hotplace/contents/storage
      
        // Ubuntu: path = "/home/ubuntu/deploy/hotplace/contents/storage";
        // ▶ file:////home/ubuntu/deploy/hotplace/contents/storage
      
        // JSP 인식되는 경로: http://localhost:9094/contents/storage";
        registry.addResourceHandler("/contents/storage/**").addResourceLocations("file:///" +  Contents.getUploadDir());
        
        // JSP 인식되는 경로: http://localhost:9094/attachfile/storage";
        // registry.addResourceHandler("/contents/storage/**").addResourceLocations("file:///" +  Tool.getOSPath() + "/attachfile/storage/");
        
        // JSP 인식되는 경로: http://localhost:9094/member/storage";
        // registry.addResourceHandler("/contents/storage/**").addResourceLocations("file:///" +  Tool.getOSPath() + "/member/storage/");
    }
 
}