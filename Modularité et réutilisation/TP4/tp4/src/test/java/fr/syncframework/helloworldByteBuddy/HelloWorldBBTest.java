package fr.syncframework.helloworldByteBuddy;

import org.junit.jupiter.api.Test;


import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.is;
import static org.junit.jupiter.api.Assertions.*;

class HelloWorldBBTest {
    HelloWorldBB helloWorldBB=new HelloWorldBB();
    @Test
    void leToStringDunProxyRetourneHelloWorld() throws InstantiationException, IllegalAccessException {
        assertThat(helloWorldBB.getProxy().newInstance().toString(), is("Hello World!"));
    }
}