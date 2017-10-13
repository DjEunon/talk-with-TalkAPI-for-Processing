import processing.net.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.io.DataOutputStream;
import java.io.UnsupportedEncodingException;
import java.net.ConnectException;
import java.net.Socket;

//plz write talkAPI_client.py path!!
//\\�ɂ��Ȃ��ƃp�X�ɂȂ���I�I

public static final String py_path="C:\\Users\talkAPI_client.py";


//global
PImage sd_img;
PImage selif_img;
PImage mik_img;
Client myClient; //Julius�Ƃ̘A�g�ŕK�v
String word="";
color col=color(0,0,0);

void setup(){
       PFont font = createFont("MS Gothic",48,true);
      textFont (font);
    sd_img=loadImage("slow_sd.png");
    selif_img=loadImage("selif.png");
    mik_img=loadImage("mik.png");
    background(255);
    scale(2);
    size(640, 480);
    myClient = new Client(this,"localhost",10500); 
}
// magic button happyou
boolean space_on=false;
boolean a_on=false;
boolean s_on=true;
void keyPressed() {
  if ( key == ' ' ) {
    space_on=true;
  }
  if(key=='a'){
  a_on=true;
  }
  if(key=='s'){
  s_on=true;
  }
}

void keyReleased(){
  space_on=false;
  a_on=false;
  s_on=false;
}

void draw(){
  loadImgset();
 //  String myword="�����V�C�ł�";
   String myword=getWord();

    myword=endE(myword);
   
   //magic key happyou-you
   if(space_on){
   myword="����";
   }
   if(a_on){
   myword="�����V�C�ł���";
   }
   if(s_on){
   myword="���͂悤";
   }
    String apiword=sendAPI(myword);
    speak(apiword);
      if(myword!=""){
       background(255);
        loadImgset();
        println("myInput   :"+myword);
        println("APIOutput :"+apiword);
       fill(0, 0, 0);
        textSize(48);       
       text(apiword,100,75,500,150);  
        textSize(32);
       text(myword,65,440,570,70);
       
    }
}

void loadImgset(){
   image(selif_img,70,50);   
   image(sd_img,340,220);
   image(mik_img,20,415);
   strokeWeight( 2 );
   line(20, 475, 620, 475);
}
String endE(String str){
String out="";
if(str != null && str.length() > 0){
    out = str.substring(0, str.length()-1);
  }
  return out;
}
//����ȍ~��Julius�Ƃ̘A�g����
String getWord(){
    String word = "";
    if (myClient.available()>0){
        String dataIn = myClient.readString();
        String[] sList = split(dataIn, "WORD");
        for(int i=1;i<sList.length;i++){
            String tmp = sList[i];
            String[] tList = split(tmp, '"');
            word += tList[1];
        }
    }
    if (word != ""){
        
}
    return word;
}

public static String sendAPI(String inputstr){
try{
  String instr;
  instr=inputstr;
//ProcessBuilder pb = new ProcessBuilder("cmd.exe","/d","/c", "curl","-X","POST","https://api.a3rt.recruit-tech.co.jp/talk/v1/smalltalk","-F","\"apikey=z6q5ZNOMdiiTS36HHGoDAVWdBHvhkvnh\"","-F","\"query="+instr+"\"");
ProcessBuilder pb = new ProcessBuilder("cmd.exe","/d","/c","python" ,py_path ,instr);

Process process = pb.start();          
process.waitFor();
String strtemp="";
BufferedReader in = new BufferedReader(new InputStreamReader(process.getInputStream()));
          String str;
          while ((str = in.readLine()) != null) {
            strtemp+=str;
          }
          //println("exit : " + process.exitValue());
          // �I���������
          process.destroy();
          in.close();
          println(strtemp);
          return convertStr(strtemp);
}catch(Exception e){
}
return "";
}
// mou nakutemoheiki
private static String convertStr(String unicode) {
        String tmp = unicode;
      StringBuilder tmp1 = new StringBuilder(unicode);
      tmp=tmp1.toString();
        while (tmp.indexOf("\\u") > 0) {
            String str = tmp.substring(tmp.indexOf("\\u"), tmp.indexOf("\\u") + 6);
            int c = Integer.parseInt(str.substring(2), 16);
            tmp = tmp.replaceFirst("\\" + str, new String(new int[]{c}, 0, 1));
        }
    return tmp;
  }
  
void speak(String str){
     BouyomiChan4J bouyomi = new BouyomiChan4J();
     bouyomi.talk(str);
 }
 
// http://howalunar.hatenablog.com/entry/2012/01/14/215229
// bouyomichan on
class BouyomiChan4J {

  private static final String DEFAULT_BOUYOMI_HOST = "localhost";
  private static final int DEFAULT_BOUYOMI_PORT = 50001;
  
  private String host;
  private int port;
  
  public BouyomiChan4J() {
    this.host = DEFAULT_BOUYOMI_HOST;
    this.port = DEFAULT_BOUYOMI_PORT;
  }
  
  public BouyomiChan4J(String host, int port) {
    this.host = host;
    this.port = port;
  }

  /**
   * �c��̕��͂��L�����Z�����܂��B
   */
  public void clear() {
    command(host, port, 64);
  }

  /**
   * �ǂݏグ���ꎞ��~���܂��B
   */
  public void pasuse() {
    command(host, port, 16);
  }

  /**
   * �ǂݏグ���ĊJ���܂��B
   */
  public void resume() {
    command(host, port, 32);
  }

  /**
   * ���̕��͂�ǂݏグ�܂��B
   */
  public void skip() {
    command(host, port, 48);
  }

  /**
   * �_�ǂ݂�����ǂݏグ�����܂��B���ʁE���x�E�����E�����̓f�t�H���g�̐ݒ�ƂȂ�܂��B
   * @param message �ǂ܂�����������
   */
  public void talk(String message) {
    talk(host, port, (short) -1, (short) -1, (short) -1, (short) 0, message);
  }
  

  /**
   * ���ʁE���x�E�����E�������w�肵�Ė_�ǂ݂�����ǂݏグ�����܂��B
   * @param volume �ǂݏグ�鉹��(0�`100, �f�t�H���g��-1)
   * @param speed �ǂݏグ�鑬�x(50�`300, �f�t�H���g��-1)
   * @param tone �ǂݏグ�鉹��(50�`200, �f�t�H���g��-1)
   * @param voice �ǂݏグ�鉹������(1�`8, �f�t�H���g��0)
   * @param message �ǂ܂�����������
   */
  public void talk(int volume, int speed, int tone, int voice, String message) {
    talk(host, port, (short) volume, (short) speed, (short) tone, (short) voice, message);
  }
  
  private void command(String host, int port, int command) {
    byte data[] = new byte[2];
    data[0] = (byte) ((command >>> 0) & 0xFF);
    data[1] = (byte) ((command >>> 8) & 0xFF);
    send(host, port, data);
  }

  private void send(String host, int port, byte[] data) {
    Socket socket = null;
    DataOutputStream out = null;
    try {
      socket = new Socket(host, port);
//      System.out.println("�ڑ����܂���" + socket.getRemoteSocketAddress());
      out = new DataOutputStream(socket.getOutputStream());
      out.write(data);
    } catch (ConnectException e) {
     // System.out.println("�ڑ��ł��܂���ł���");
//      e.printStackTrace();
    } catch (IOException e) {
      e.printStackTrace();
    } finally {
      try {
        if (out != null) {
          out.close();
        }
        if (socket != null) {
          socket.close();
//          System.out.println("�ؒf���܂�");
        }
      } catch (IOException e) {
        e.printStackTrace();
      }
//      System.out.println("�I�����܂�");
    }
  }

  private void talk(String host, int port, short volume, short speed, short tone, short voice, String message) {
      byte messageData[] = null;
      try {
        messageData = message.getBytes("UTF-8");
      } catch (UnsupportedEncodingException e) {
        e.printStackTrace();
      }
      int length = messageData.length;
      byte data[] = new byte[15 + length];
      data[0] = (byte) 1;   // �R�}���h 1����
      data[1] = (byte) 0;   // �R�}���h 2����
      data[2] = (byte) ((speed >>> 0) & 0xFF); // ���x 1����
      data[3] = (byte) ((speed >>> 8) & 0xFF); // ���x 2����
      data[4] = (byte) ((tone >>> 0) & 0xFF); // ���� 1����
      data[5] = (byte) ((tone >>> 8) & 0xFF); // ���� 2����
      data[6] = (byte) ((volume >>> 0) & 0xFF); // ���� 1����
      data[7] = (byte) ((volume >>> 8) & 0xFF); // ���� 2����
      data[8] = (byte) ((voice >>> 0) & 0xFF); // ���� 1����
      data[9] = (byte) ((voice >>> 8) & 0xFF); // ���� 2����
      data[10] = (byte) 0; // �G���R�[�h(0: UTF-8)
      data[11] = (byte) ((length >>> 0) & 0xFF); // ���� 1����
      data[12] = (byte) ((length >>> 8) & 0xFF); // ���� 2����
      data[13] = (byte) ((length >>> 16) & 0xFF);   // ���� 3����
      data[14] = (byte) ((length >>> 24) & 0xFF); // ���� 4����      
      System.arraycopy(messageData, 0, data, 15, length);
      send(host, port, data);
  } 
}