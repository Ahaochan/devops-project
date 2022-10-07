package moe.ahao.devops;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * SpringBoot方式启动类
 *
 * @author Ahaochan
 */
@SpringBootApplication(scanBasePackages = "moe.ahao.devops")
public class DevopsApplication {
    private static final Logger logger = LoggerFactory.getLogger(DevopsApplication.class);

    public static void main(String[] args) {
        try {
            SpringApplication app = new SpringApplication(DevopsApplication.class);
            app.run(args);
            logger.info("{}启动成功!", DevopsApplication.class.getSimpleName());
        } catch (Exception e) {
            logger.error("{}启动失败!", DevopsApplication.class.getSimpleName(), e);
        }
    }
}
