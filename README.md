# Vigil

Flutter tabanlı mobil takip uygulaması.

## Özellikler Versiyon 1

Başlıca özellikler:
- Anlık konumun nerede olduğunu görmeyi sağlayacak.
- Araç kullanım halinde hız takibi
  - Araç sürüş puanı sistemi ile ani manevra, ani hızlanma tarzı değerleri toplayarak belirli bir araç kullanım puanı sunacak. Puanı düştüğünde ise diğer üyelere bildirim sağlayacak.
- Yetki sistemi ile belirli gizlilik ayarları.
  - Çocuk modu sayesinde kurulu olduğu telefonda herhangi bir ayara erişim sağlanamayacak. Uygulamaya giriş sağladığında sadece yardım isteme tuşunu kullanabilecek onun haricinde hiç bir ayara erişimi olmayacak.
  - Grup üyeleri arasında belirli yetkiler olucak bunlar;
    - Grup yöneticisi bu kişi her şeyi kontrol edebilecek ve kişilere istediği yetkiyi verebilecek. İsterse grup yöneticisi grup içerisindeki bazı veri paylaşımlarını kısıtlayabilecek örneğiş A kişisinin konumunu sadece B kişisi görebilecek. Diğer grup üyelerinede bazı ayarları düzenlemeleri için yetki verebilecek.
    - Grup üyesi yetkisinde sadece grup üyesinin ayarlamalarına göre uygulamayı kullanabilecek ancak grup yöneticisi isterse herhangi bir grup üyesinede kendisi kadar yüksek yetkiler verebilir.
    - Çocuk modu ise herhangi bir uygulama içi hiç bir şeye erişemeyecek ancak sadece uygulama içi yardım butonunu kullanabilecek.
    - Engelli modu ise daha hassas bir mod olacak, bu mod sayesinde özel yardıma ihtiyacı olan insanlar daha çok kontrol altında olacak. örneğin ona belirlediğiniz konum alanı olacak bu konum alanının dışına çıktığında hemen uyarı verilecek. Bunun haricinde ise konumu bir süre aynı yerde kaldığında uyarı verilecek. Herhangi bir yerde kaldığında belirli bir konuma gitmek istediğinde ona gitmek istediği konumu tarif ederek kolaylıkla ulaşmasını sağlayacak.
- Etkinlik özelliği ile grup üyeleri arasında bir etkinlik başlatabilme. Bu sayede belirli bir konum ayarlayarak grup üyelerin etkinliğe katılıp katılmayacağını görme ve etkinlik konumuna herhangi biri gittiğinde diğer üyelere bildirme. Bir üye bulunduğu konumdan etkinlik yerine gelmesi için çıktığında eğer hesaplamalara göre geç kalacağı anlaşıldığında diğer üyelere bildirim gönderecek. Etkinliğe gelecek kişilere etkinlik oluşturulduğunda nasıl gelecekleri sorulacak. Örneğin bir kişi araç ile geleceğini söylediğinde diğerleri o kişinin aracında geleceğini bildirebilecek ve yakın konumdaki kişiler farklı araçla geleceğini bildirdiğinde onlara bir öneri sunarak beraber gitmeleri halinde doğaya verecekleri zararın azaldığını göstererek onları daha iyi bir çevre yaratmaya yönlendirecek.  
## Özellikler Versiyon 2

 2 adet bileklik tipi olacak bunlar uygulamayla birlikte çalışacak.

1. bileklik türü çocuklara özel olucak anlık konumlarını uygulama indirmeye kalmadan takip edebilme olanağı. Sağlık verilerini kontrol ederek bunlarla belirli hesaplamalar yaparak stres altında olduğu veya herhangi başka bir sorunu olduğunu tespit ederek aile bireylerine bildiricek. (Vigil Kids)
2. bileklik türü ise engelli bireylere özel olacak bileklik 1. tür ile aynı özelliklere sahip olacak ancak bunun haricinde üst tarafında bir radar ile birlikte gelecek. üst tarafta bulunan bu radar engelli bireyin görme yetisi yetmediği zamanlarda etrafı tarayarak onu güvenli bir şekilde engellerden koruyacak. bu radarın yanında bir kamerada bulunacak bu kamera sayesinde etraftaki belirli engellere karşı yönlendirme sağlayacak örneğin bir yola doğru gittiğinde uyararak bildirecek ve onu trafik ışığına yönlendirecek. Ardından kişiye tarif ederek trafik ışığına basmasını sağlayacak. Işık yeşile döndüğünde ise güvenli bir şekilde karşıya geçişini sağlayacak. Bu cihaz bir beyine sahip olup geçtiği yerleri ezberleyip diğer kullanıcılara daha iyi bir deneyim sunucak. Navigasyon özelliğiyle gitmek istediği yere engelli bireyi sorunsuz bir şekilde götürebilecek. Bu navigasyon özelliği sadece uydudan aldığı bilgilerle çalışmayacak cihaz üzerindeki kamera sayesinde etrafı tarayarak daha güvenli bir yönlendirme yapacak. Örneğin yaya yolu yerine araç yolunda yüründüğünü farkettiğinde uyarı vererek bildirecek. Cihazın üzerindeki kamera gece görüşü sayesinde de çok rahat bir şekilde çalışacak. (Vigil Eye)
