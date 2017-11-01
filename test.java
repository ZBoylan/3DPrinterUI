import processing.core.PApplet;
import controlP5.*;



public class test extends PApplet {

    private ControlP5 cp5;

    public static void main(String[] args) {
        PApplet.main(new String[]{test.class.getCanonicalName()});
    }

    @Override
    public void settings() {
        size(1000, 600); //
    }

    @Override
    public void setup() {
        cp5 = new ControlP5(this);
        cp5.addButton("test").setImage(loadImage("gear.png"));
        Button button1 = cp5.addButton("Button 1").setPosition(700, 50);

    }

    @Override
    public void draw() {
        //rect(mouseX, mouseY, 20, 20);
    }

    public void test()
    {

    }
}
