package org.example;

public aspect test {
    private static boolean flag = false;

    public static boolean testAndClear() {
        boolean result = flag;
        flag = false;
        return result;
    }

    pointcut moves():
            call(void Ligne.setP1(Point)) ||
            call(void Ligne.setP2(Point));

    after(): moves() {
        System.out.println("test");
        flag = true;
    }
}
