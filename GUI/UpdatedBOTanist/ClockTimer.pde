////https://www.youtube.com/watch?v=VT6kXdjW1a8
//class ClockTimer extends PageElement {

//  int h = hour(); //Values from 1-24
//  int m = minute(); //Values from 0-59
//  int s = second(); //Values from 0-59
//  float hour, minute, second, time;

//  }

//  void render() {
//    colortime=color(0,0,0);

//    //Time will be in military time
//    if(time <= 6.30 && time >= 20) colortime = color(0,0,255); //8PM-6:30AM is night time which is blue
//    if(time <= 17 && time >= 20) colortime = color(255,165,0); //5PM-8PM is sunset which is orange
//    if(time <= 6.30 && time >= 17) colortime = color(255,255,0); //6:30AM-5PM is morning, noon, and afternoon is yellow
//    fill(colortime);
    

//    second();
//    if (s==59){
//      s=0;
//      m==1;
//    }
    
//    minute();  
//    if (m==59){
//     m=0;
//     h==1;
//    }
    
//    hour();
//    if (h==24){
//     h=0;
//     m=0;
//     s=0;
//    }
   
//    //Text and Numbers
//    textSize(30);
//    fill(255);
//    text(floor(s),140,50);
//    text(floor(m),80,50);
//    text(floor(h),20,50);
    
//    //Blinking dots
//    if (sec % 2==0){
//      col=color(255);
//    }else{
//      col=color(0);
//    }
//    fill(col);
//    ellipse(70,30,8,8);
//    ellipse(70,45,8,8);
//    ellipse(130,30,8,8);
//    ellipse(130,45,8,8);
//    }
    
//  }
