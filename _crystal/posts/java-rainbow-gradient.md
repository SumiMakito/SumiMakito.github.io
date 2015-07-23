有时在Android项目中需要用到渐变色，而Google貌似并没有提供这种取得连续渐变色的API，不过这段Java代码就可以简单的取得一个连续渐变色列表。

这段代码实现了赤→橙→黄→绿→蓝→靛→紫的颜色渐变，这七种颜色的RGB值的变化规律类似于正弦函数，但这里为了方便就转换为线性关系处理。

<pre>
/*
 * Copyright (c) 2014 SumiMakito
 */

package sumimakito.android.reina;

import java.util.*;  
import android.graphics.*;

public class ReinaGradient  
{
    private int startColor;
    private int endColor;
    private int division;
    private int alpha;

    public ReinaGradient(){
        this.startColor = 0; //Don't modify.
        this.endColor = 0; //Don't modify.
        this.division = 80; //Divide a color section to ? pieces.
        this.alpha = 140; //Global alpha.
    }

 //Idle contributor. It' s unnecessary for you.
    protect ReinaGradient(int startColor, int endColor, int division, int alpha){
        this.startColor = startColor;
        this.endColor = endColor;
        this.division = division;
        this.alpha = alpha;
    }

/*
 * This method will return a List which contains integer colors ordered by hue.
 * Order: A -> Z -> A
 */
    public List<Integer> getColors(){
        if(startColor==0&&endColor==0){
            ArrayList<Integer> list = new ArrayList<Integer>();
            int avgP = (int) Math.ceil(division / 4);
            int avgStep = (int) Math.ceil(255 / avgP);
            for(int g=75;g<175;g+=avgStep){
                int color = Color.argb(alpha, 175, g, 0);
                list.add(color);
            }
            for(int r=175;r>0;r-=avgStep){
                int color = Color.argb(alpha, r, 175, 0);
                list.add(color);
            }
            for(int b=0;b<175;b+=avgStep){
                int color = Color.argb(alpha, 0, 175, b);
                list.add(color);
            }
            for(int g=175;g>75;g-=avgStep){
                int color = Color.argb(alpha, 0, g, 175);
                list.add(color);
            }
            for(int r=0;r<175;r+=avgStep){
                int color = Color.argb(alpha, r, 75, 175);
                list.add(color);
            }
            for(int b=175;b>0;b-=avgStep){
                int color = Color.argb(alpha, 175, 75, b);
                list.add(color);
            }
            return list;
        }else{
            return null;
        }
    }
}
</pre>
