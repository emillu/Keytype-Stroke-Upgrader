#include <SPI.h>

#define pin_sum 8
#define MCP3208_CI 10

void setup() {
  Serial.begin(9600);
  SPI.begin();
  SPI.setBitOrder(MSBFIRST) ;
  SPI.setDataMode(SPI_MODE1) ;
  SPI.setClockDivider(SPI_CLOCK_DIV8) ;
}

void loop() {
  Serial.write('a');
  for(int i = 0; i < pin_sum; i++){
      Serial.write(ADC_analogRead(MCP3208_CI, i)/4);
    }
}

int ADC_analogRead(int useDigitalPin,int channel)
{
     static char f ;
     int d1 , d2 ;

     // 指定されたSSピンを出力に設定する(但し最初コールの１回のみ)
     if (f != 1) {
          pinMode(useDigitalPin,OUTPUT) ;
          digitalWrite(useDigitalPin,HIGH) ;
          f = 1 ;
          delay(1) ;
     }
     // ADCから指定チャンネルのデータを読み出す
     digitalWrite(useDigitalPin,LOW) ;              // SS(CS)ラインをLOWにする
     d1 = SPI.transfer( 0x06 | (channel >> 2) ) ;
     d1 = SPI.transfer( channel << 6 ) ;
     d2 = SPI.transfer(0x00) ;
     digitalWrite(useDigitalPin,HIGH) ;             // SS(CS)ラインをHIGHにする

     return (d1 & 0x0F)*256 + d2 ;
}
