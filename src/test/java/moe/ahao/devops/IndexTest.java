package moe.ahao.devops;

import moe.ahao.devops.controller.IndexController;
import org.junit.Assert;
import org.junit.Test;

public class IndexTest {
    @Test
    public void toLowerCaseTest() {
        String data1 = "HELLO WORLD";
        String data2 = new IndexController().toLowerCase(data1);
        Assert.assertEquals(data1.toLowerCase(), data2);
    }
}
