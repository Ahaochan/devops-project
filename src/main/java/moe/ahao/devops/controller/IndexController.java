package moe.ahao.devops.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.text.SimpleDateFormat;
import java.util.Date;

@RestController
public class IndexController {

    @GetMapping("/toLowerCase")
    public String toLowerCase(@RequestParam String data) {
        return data.toLowerCase();
    }

    @GetMapping("/now")
    public String now() {
        return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
    }
}
