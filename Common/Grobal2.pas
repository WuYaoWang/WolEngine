unit Grobal2;

interface
uses
  Windows, Classes, JSocket, IniFiles,Graphics;
const

  MAXLEVEL = 500;
  MAXMAGIC = 40;
  sSTRING_GOLDNAME = '���';
  MAXPETSELLCOUNT=10;
  LA_UNDEAD = 1; //?
  ET_FIRE = 5; //  22;    ��
  ET_HOLYCURTAIN = 4; //��ħ��
  ET_STONEMINE = 2;
  ET_DIGOUTZOMBI = 1; //�ӵ���������
  ET_PILESTONES = 3;
  ET_SCULPEICE = 6;



  LOG_GAMEGOLD = 1;
  LOG_GAMEPOINT = 2;
  MAXBAGITEM = 46; //��������
  SLAVEMAXLEVEL = 8; //ū������󼶱�
  sSTATUS_FAIL = '+FL/';
  sSTATUS_GOOD = '+G/';



  SKILL_FIREBALL = 1;
  SKILL_HEALLING = 2;
  SKILL_ILKWANG = 3;
  SKILL_YEDO = 7;

  SKILL_FIREBALL2 = 5;
  SKILL_AMYOUNSUL = 6;
  SKILL_ONESWORD = 4;
  SKILL_FIREWIND = 8;
  SKILL_FIRE = 9;
  SKILL_SHOOTLIGHTEN = 10;
  SKILL_LIGHTENING = 11; //�׵�
  SKILL_ERGUM = 12;
  SKILL_FIRECHARM = 13;
  SKILL_HANGMAJINBUB = 14;
  SKILL_DEJIWONHO = 15;
  SKILL_HOLYSHIELD = 16;
  SKILL_SKELLETON = 17;
  SKILL_CLOAK = 18;
  SKILL_BIGCLOAK = 19;
  SKILL_TAMMING = 20;
  SKILL_SPACEMOVE = 21;
  SKILL_EARTHFIRE = 22;
  SKILL_FIREBOOM = 23;
  SKILL_LIGHTFLOWER = 24;
  SKILL_BANWOL = 25;
  SKILL_FIRESWORD = 26;
  SKILL_MOOTEBO = 27;
  SKILL_SHOWHP = 28;
  SKILL_BIGHEALLING = 29;
  SKILL_SINSU = 30;
  SKILL_SHIELD = 31;
  SKILL_KILLUNDEAD = 32;
  SKILL_SNOWWIND = 33;
  SKILL_UNAMYOUNSUL = 65; //�ⶾ��
  SKILL_WINDTEBO = 37; // ʨ�Ӻ�
  SKILL_MABE = 36;
  SKILL_GROUPLIGHTENING = 53; //���׺�
  SKILL_GROUPAMYOUNSUL = 38;
  SKILL_GROUPDEDING = 39; // �ض�}
  SKILL_40 = 40; //��Ӱ����
  SKILL_41 = 41; //ѪӰ����
  SKILL_35 = 35; //��������

  SKILL_42 = 42; //���ն
  SKILL_43 = 43; //���µ���
  SKILL_44 = 44; //������
  SKILL_45 = 45; //�����
  SKILL_46 = 46; //������
  SKILL_47 = 47; //��������
  SKILL_48 = 48; //������
  SKILL_49 = 49; //������
  SKILL_50 = 50; //�����
  SKILL_51 = 51; //����ٻ���
  SKILL_52 = 52; //������
  SKILL_53 = 53; //����ٻ���
  SKILL_54 = 54; //������

  SKILL_61 = 61;
  SKILL_63 = 63;
  SKILL_64 = 64;
  SKILL_66 = 66;
  SKILL_67 = 67; //��ڤ����
  SKILL_68 = 68;
  SKILL_69 = 69;
  SKILL_70 = 70;
  SKILL_71 = 71; //�����ϵ�
  SKILL_72 = 72;
  SKILL_73 = 73;
  SKILL_74 = 74;
 // SKILL_68

  Skill_75 = 75; //�ݵ�
  SKILL77 = 77;
  SKILL78 = 78;
  SKILL85 = 85;
  SKILL_87 = 87; //ǿ������
  SKILL_88 = 88;
  SKILL_89 = 89;
//====================
  RUNGATECODE =$e567b25d ; // $AA55AA55;

//  RUNGATECODE

  GS_QUIT = 0;
  GS_USERACCOUNT = 1;
  GS_CHANGEACCOUNTINFO = 2;

  SG_FORMHANDLE = 1000;
  SG_STARTNOW = 1001;
  SG_STARTOK = 1002;

  SG_USERACCOUNT = 1003;
  SG_USERACCOUNTNOTFOUND = 1004;
  SG_USERACCOUNTCHANGESTATUS = 1005;
  SG_CHECKCODEADDR = 1006;




  SS_OPENSESSION = 100;
  SS_CLOSESESSION = 101;
  SS_SERVERINFO = 103;
  SS_LOGINCOST = 103; //?
  SS_KEEPALIVE = 104;
  SS_SOFTOUTSESSION = 105;

  SS_KICKUSER = 111;
  SS_SERVERLOAD = 113;
  UNKNOWMSG = 106;


  SS_200 = 200;
  SS_201 = 201;
  SS_202 = 202;
  SS_WHISPER = 203;
  SS_204 = 204;
  SS_205 = 205;
  SS_206 = 206;
  SS_207 = 207;
  SS_208 = 208;
  SS_209 = 209;
  SS_210 = 210;
  SS_211 = 211;
  SS_212 = 212;
  SS_213 = 213;
  SS_214 = 214;




  DBR_FAIL = 2000; //DBS ���Գɹ�
  DBR_LOADHUMANRCD = 1100;
  DBR_SAVEHUMANRCD = 1102;
  DBR_NEWYSRCD = 1102;
  DBR_LOCALIP = 1103;

  DB_LOADHUMANRCD = 100; //100;
  DB_SAVEHUMANRCD = 101; //101;
  DB_SAVEHUMANRCDEX = 102; //102;  //
  DB_NEWYS = 103; //103;
  DB_M2ASKFORLOCALIP = 104; //104;

/////////////////////// ///////////////////////////
  DR_UP = 0;
  DR_UPRIGHT = 1;
  DR_RIGHT = 2;
  DR_DOWNRIGHT = 3;
  DR_DOWN = 4;
  DR_DOWNLEFT = 5;
  DR_LEFT = 6;
  DR_UPLEFT = 7;

  U_DRESS = 0;
  U_WEAPON = 1;
  U_RIGHTHAND = 2;
  U_NECKLACE = 3;
  U_HELMET = 4;
  U_ARMRINGL = 5;
  U_ARMRINGR = 6;
  U_RINGL = 7;
  U_RINGR = 8;
   //
  U_BOOTS = 9; // ����4����Ʒ   Ь��
  U_BELT = 10; //  ����
  U_CHARM = 11; //  ��ʯ
  U_BUJUK = 12; //          // ��Ʒ
  U_Shield =13;

  DEFBLOCKSIZE = 16;
  BUFFERSIZE = 50000;
  DATA_BUFSIZE = 8192;

  GROUPMAX = 11;
  BAGGOLD = 5000000;
  BODYLUCKUNIT = 10;
  STATE_STONE_MODE = 1; //ʯ�� ��־    ���������ֵ�״̬
  MAX_STATUS_ATTRIBUTE = 16; //����״̬ >12   =16 [0..15]
//����״̬���鱣��λ��
  POISON_DECHEALTH = 0; //���̶�
  POISON_DAMAGEARMOR = 1; //�к춾
  POISON_LOCKSPELL = 2; //ħ������
                                    //=3 δ֪
  POISON_DAOCAO1 = 4; //����Ϊ����״̬ ��ɫ
  POISON_STONE = 5; //���
  POISON_DAOCAO2 = 6; //68;  // ����Ϊ����״̬ �ۺ�ɫ


  STATE_OPENHEATH = 7; //
  STATE_TRANSPARENT = 8; // �����־

  STATE_DEFENCEUP = 9; //�ӷ���
  STATE_MAGDEFENCEUP = 10; //��ħ��
  STATE_BUBBLEDEFENCEUP = 11; // ħ���ܱ�־
  STATE_12 = 12; //�����ͷ��־     //
                       //13       δ֪
  STATE_14 = 14; //14  ��������
  STATE_15 = 15; //����ֱ�־
///////////////////




  USERMODE_PLAYGAME = 1; //
  USERMODE_LOGIN = 2;
  USERMODE_LOGOFF = 3;
  USERMODE_NOTICE = 4; //
 //
  CM_GETGAMELIST = 100;
  SM_SENDGAMELIST = 101;


 //

  CM_TAKEHORSE = 64;

  CM_42HIT = 42;
  CM_QUERYUSERSTATE = 82;

  CM_QUERYUSERSET = 83;

  CM_QUERYUSERNAME = 80;
  CM_QUERYBAGITEMS = 81;

  CM_HACK = 40013;
  CM_LOOPDEATH = 20010; //10010 for v1.26
  CM_QUERYCHR = 100;
  CM_NEWCHR = 101;
  CM_DELCHR = 102;
  CM_SELCHR = 103;
  CM_SELECTSERVER = 104;
  CM_UNDELCHR = 105;




  CM_DROPITEM = 1000;
  CM_PICKUP = 1001;
  CM_OPENDOOR = 1002;
  CM_TAKEONITEM = 1003;
  CM_TAKEOFFITEM = 1004;
  CM_1005 = 1005;
  CM_EAT = 1006;
  CM_BUTCH = 1007;
  CM_MAGICKEYCHANGE = 1008;
  CM_SOFTCLOSE = 1009;
  CM_CLICKNPC = 1010;
  CM_MERCHANTDLGSELECT = 1011;
  CM_MERCHANTQUERYSELLPRICE = 1012;
  CM_USERSELLITEM = 1013;
  CM_USERBUYITEM = 1014;
  CM_USERGETDETAILITEM = 1015;
  CM_DROPGOLD = 1016;
  CM_1017 = 1017;
  CM_LOGINNOTICEOK = 1018;
  CM_GROUPMODE = 1019;
  CM_CREATEGROUP = 1020;
  CM_ADDGROUPMEMBER = 1021;
  CM_DELGROUPMEMBER = 1022;

  CM_GROUPMEMBERXY = 1055;

  CM_USERREPAIRITEM = 1023;
  CM_MERCHANTQUERYREPAIRCOST = 1024;
  CM_DEALTRY = 1025;
  CM_DEALADDITEM = 1026;
  CM_DEALDELITEM = 1027;
  CM_DEALCANCEL = 1028;
  CM_DEALCHGGOLD = 1029;
  CM_DEALEND = 1030;
  CM_USERSTORAGEITEM = 1031;
  CM_USERTAKEBACKSTORAGEITEM = 1032;
  CM_WANTMINIMAP = 1033;
  CM_USERMAKEDRUGITEM = 1034;
  CM_OPENGUILDDLG = 1035;
  CM_GUILDHOME = 1036;
  CM_GUILDMEMBERLIST = 1037;
  CM_GUILDADDMEMBER = 1038;
  CM_GUILDDELMEMBER = 1039;
  CM_GUILDUPDATENOTICE = 1040;
  CM_GUILDUPDATERANKINFO = 1041;
  CM_1042 = 1042;
  CM_ADJUST_BONUS = 1043;
  CM_GUILDALLY = 1044;
  CM_GUILDBREAKALLY = 1045;
  CM_SPEEDHACKUSER = 10430; //??

  CM_PROTOCOL = 2000;
  CM_IDPASSWORD = 2001;
  CM_ADDNEWUSER = 2002;
  CM_CHANGEPASSWORD = 2003;
  CM_UPDATEUSER = 2004;
  CM_GETBACKPASSWORD = 2005;

  CM_PASSWORD = 2001;
  CM_CHGPASSWORD = 2003;
  CM_SETPASSWORD = 2004;               



  CM_THROW = 3005;
  CM_HORSERUN = 3009; //3013
  CM_TURN = 3010;
  CM_WALK = 3011;
  CM_SITDOWN = 3012;
  CM_RUN = 3013;
  CM_HIT = 3014;
  CM_HEAVYHIT = 3015;
  CM_BIGHIT = 3016;
  CM_SPELL = 3017;
  CM_POWERHIT = 3018;
  CM_LONGHIT = 3019;
  CM_CRSHIT = 30200; //����δ�� 3020
  CM_TWNHIT = 30211;

  CM_WIDEHIT = 3024;
  CM_FIREHIT = 3025;
  CM_3026HIT = 3026; //

  CM_SAY = 3030;
  CM_RIDE = 3031;
  CM_26771 = 26771; //�޸ĸ��Ի�ǩ��
  CM_ADDFRIEND = 66;
  CM_DELFRIEND = 67;
  CM_ADDASK = 68;
  CM_SENDSELL = 24241; //��ʼ��̯


  RUNGATEMAX = 200;
  // For Game Gate
  GM_OPEN = 1; //���� 1
  GM_CLOSE = 2; //���� 2
  GM_CHECKSERVER = 3; // Send check signal to Server
  GM_CHECKCLIENT = 4; // Send check signal to Client

  GM_DATA = 5; // ���� 5
  GM_SERVERUSERINDEX = 6;
  GM_RECEIVE_OK = 7;
                         // ���� 7
  GM_TEST = 20;



  OS_MOVINGOBJECT = 1;
  OS_ITEMOBJECT = 2;
  OS_EVENTOBJECT = 3;
  OS_GATEOBJECT = 4;
  OS_SWITCHOBJECT = 5;
  OS_MAPEVENT = 6;
  OS_DOOR = 7;
  OS_ROON = 8;
  OS_NEWMAPEVENT=9;

  RC_PLAYOBJECT = 1; //OK��
  RC_YSBJECT = 254;
  RC_EVILOBJECT = 253;
  RC_MONSTER = 53; //ok    // ��   �����������ġ�
//��   if (BaseObject.m_btRaceServer >= RC_ANIMAL) and (BaseObject.m_btRaceServer < RC_MONSTER) then begin

  RCC_MERCHANT = 50; //���˵����   OK
  RCC_GUARD = 12;


  RC_ANIMAL = 50; //ok     // ��������������
  RC_NPC = 8; //  OK
  RC_PEACENPC = 15; //OK
  RC_ARCHERGUARD = 112; //OK     112
  RC_GUARD = 12; //OK


  ISM_WHISPER = 1234;

  //������ģ��֮��
  SM_OPENSESSION = 100; //��� ��Ϊ�������ݡ�
  SM_CLOSESESSION = 101;
  CM_CLOSESESSION = 102;



  SM_PASSWORD = 1; //?
  SM_PLAYDICE = 2; /// ?
  SM_PASSWORDSTATUS = 3; //?
  SM_PUSHX = 5;
  SM_RUSH = 6;
  SM_RUSHKUNG = 7; //
  SM_FIREHIT = 8; //�һ�
  SM_BACKSTEP = 9;
  SM_TURN = 10;
  SM_WALK = 11; //��
  SM_TAKEHORSE = 12; //��������   SM_SITDOWN
  SM_RUN = 13;
  SM_HORSERUN = 13; //?
  SM_HIT = 14; //��
  SM_HEAVYHIT = 15; //
  SM_BIGHIT = 16; //
  SM_SPELL = 17; //ʹ��ħ��
  SM_POWERHIT = 18;
  SM_LONGHIT = 19; //��ɱ
  SM_DIGUP = 20;
  SM_DIGDOWN = 21;
  SM_FLYAXE = 22;
  SM_LIGHTING = 23;
  SM_WIDEHIT = 24;
  SM_25 = 25; //�ƶ�
  SM_ALIVE = 27;
  SM_MOVEFAIL = 28; //
  SM_HIDE = 29; //��ջ������ɫѪ��  ������������Ѫ����
  SM_DISAPPEAR = 30;
  SM_STRUCK = 31; //�������� ����һ�¡�
  SM_DEATH = 32;
  SM_SKELETON = 33;
  SM_NOWDEATH = 34;

  SM_ACTION_MIN = SM_RUSH;
  SM_ACTION_MAX = SM_WIDEHIT;
  SM_ACTION2_MIN = 65072;
  SM_ACTION2_MAX = 65073;

  SM_HEAR = 40;
  SM_FEATURECHANGED = 41; //����   41
  SM_41 = 41;
  SM_USERNAME = 42;
  SM_42 = 42;
  SM_43 = 43;
  SM_WINEXP = 44;
  SM_LEVELUP = 45;
  SM_DAYCHANGING = 46;
  SM_47 = 47; // ����� �ƶ��ƻ� ����ֵ��¼��ܵ� ���к�ħ��Ч�����

  SM_LOGON = 50; //����  50
  SM_NEWMAP = 51;
  SM_ABILITY = 52; //����ֵ
  SM_HEALTHSPELLCHANGED = 53;
  SM_MAPDESCRIPTION = 54;
  SM_SPELL2 = 117;

  SM_SYSMESSAGE = 100;
  SM_GROUPMESSAGE = 101;
  SM_CRY = 102;
  SM_WHISPER = 103;
  SM_GUILDMESSAGE = 104;

  SM_SPYMOVE = 170; //���� 170
  SM_SELLITEM = 64672; //���� 64672

  SM_ADDITEM = 200;
  SM_BAGITEMS = 201; //���� 201
  SM_DELITEM = 202;
  SM_UPDATEITEM = 203;
  SM_204 = 204; //δ֪
  SM_ONHORSE = 205; //�Ƿ������� dwflag=0  wcmd=205 w1=0 w2=0 w3=0 data=    dwflag=1 ��ʾ������

  SM_ADDMAGIC = 210; //���� 210
  SM_SENDMYMAGIC = 211; //���� 211
  SM_DELMAGIC = 212;

  SM_CERTIFICATION_SUCCESS = 500;
  SM_CERTIFICATION_FAIL = 501;
  SM_ID_NOTFOUND = 502;
  SM_PASSWD_FAIL = 503;
  SM_NEWID_SUCCESS = 504;
  SM_NEWID_FAIL = 505;
  SM_CHGPASSWD_SUCCESS = 506;
  SM_CHGPASSWD_FAIL = 507;
  SM_GETBACKPASSWD_SUCCESS = 508;
  SM_GETBACKPASSWD_FAIL = 509;

  SM_510 = 510;
  SM_QUERYCHR = 520;
  SM_NEWCHR_SUCCESS = 521;
  SM_NEWCHR_FAIL = 522;
  SM_DELCHR_SUCCESS = 523;
  SM_DELCHR_FAIL = 524;
  SM_STARTPLAY = 525;
  SM_STARTFAIL = 526; //SM_USERFULL
  SM_QUERYCHR_FAIL = 527;
  SM_OUTOFCONNECTION = 528;
  SM_PASSOK_SELECTSERVER = 529;
  SM_SELECTSERVER_OK = 530;
  SM_NEEDUPDATE_ACCOUNT = 531;
  SM_UPDATEID_SUCCESS = 532;
  SM_UPDATEID_FAIL = 533;
  SM_QUERYDELCHR = 534;
  SM_QUERYDELCHR_FAIL = 535;

  SM_DROPITEM_SUCCESS = 600;
  SM_DROPITEM_FAIL = 601;

  SM_ITEMSHOW = 610;
  SM_ITEMHIDE = 611;
//  SM_DOOROPEN           = 612;
  SM_OPENDOOR_OK = 612; //
  SM_OPENDOOR_LOCK = 613;
  SM_CLOSEDOOR = 614;
  SM_TAKEON_OK = 615;
  SM_TAKEON_FAIL = 616;
  SM_TAKEOFF_OK = 619;
  SM_TAKEOFF_FAIL = 620;
  SM_SENDUSEITEMS = 621;
  SM_WEIGHTCHANGED = 622;

  SM_MAKESTONE = 624; //


  SM_CLEAROBJECTS = 633;
  SM_CHANGEMAP = 634;
  SM_EAT_OK = 635;
  SM_EAT_FAIL = 636;
  SM_BUTCH = 637;
  SM_MAGICFIRE = 638;
  SM_MAGICFIRE_FAIL = 639;
  SM_MAGIC_LVEXP = 640;
  SM_DURACHANGE = 642;
  SM_MERCHANTSAY = 643;
  SM_MERCHANTDLGCLOSE = 644;
  SM_SENDGOODSLIST = 645;
  SM_SENDUSERSELL = 646;
  SM_SENDBUYPRICE = 647;
  SM_USERSELLITEM_OK = 648;
  SM_USERSELLITEM_FAIL = 649;
  SM_BUYITEM_SUCCESS = 650; //?
  SM_BUYITEM_FAIL = 651; //?
  SM_SENDDETAILGOODSLIST = 652;
  SM_GOLDCHANGED = 653;
  SM_CHANGELIGHT = 654;
  SM_LAMPCHANGEDURA = 655;
  SM_CHANGENAMECOLOR = 656;
  SM_CHARSTATUSCHANGED = 657; //hint
  SM_SENDNOTICE = 658;
  SM_GROUPMODECHANGED = 659; //
  SM_CREATEGROUP_OK = 660;
  SM_CREATEGROUP_FAIL = 661;
  SM_GROUPADDMEM_OK = 662;
  SM_GROUPDELMEM_OK = 663;
  SM_GROUPADDMEM_FAIL = 664;
  SM_GROUPDELMEM_FAIL = 665;
  SM_GROUPCANCEL = 666;
  SM_GROUPMEMBERS = 667;
  SM_SENDUSERREPAIR = 668;
  SM_USERREPAIRITEM_OK = 669;
  SM_USERREPAIRITEM_FAIL = 670;
  SM_SENDREPAIRCOST = 671;
  SM_DEALMENU = 673;
  SM_DEALTRY_FAIL = 674;
  SM_DEALADDITEM_OK = 675;
  SM_DEALADDITEM_FAIL = 676;
  SM_DEALDELITEM_OK = 677;
  SM_DEALDELITEM_FAIL = 678;
  SM_DEALCANCEL = 681;
  SM_DEALREMOTEADDITEM = 682;
  SM_DEALREMOTEDELITEM = 683;
  SM_DEALCHGGOLD_OK = 684;
  SM_DEALCHGGOLD_FAIL = 685;
  SM_DEALREMOTECHGGOLD = 686;
  SM_DEALSUCCESS = 687;
  SM_SENDUSERSTORAGEITEM = 700;
  SM_STORAGE_OK = 701;
  SM_STORAGE_FULL = 702;
  SM_STORAGE_FAIL = 703;
  SM_SAVEITEMLIST = 704;
  SM_TAKEBACKSTORAGEITEM_OK = 705;
  SM_TAKEBACKSTORAGEITEM_FAIL = 706;
  SM_TAKEBACKSTORAGEITEM_FULLBAG = 707;

  SM_AREASTATE = 708;
  SM_MYSTATUS = 766; //���� 766

  SM_DELITEMS = 709;
  SM_READMINIMAP_OK = 710;
  SM_READMINIMAP_FAIL = 711;
  SM_SENDUSERMAKEDRUGITEMLIST = 712;
  SM_MAKEDRUG_SUCCESS = 713;
//  714
  SM_716 = 716; //  716
  SM_MAKEDRUG_FAIL = 65036;

  SM_CHANGEGUILDNAME = 750;
  SM_SENDUSERSTATE = 751; //
  SM_SUBABILITY = 752; //���� 752
  SM_OPENGUILDDLG = 753; //
  SM_OPENGUILDDLG_FAIL = 754; //
  SM_SENDGUILDMEMBERLIST = 756; //
  SM_GUILDADDMEMBER_OK = 757; //
  SM_GUILDADDMEMBER_FAIL = 758;
  SM_GUILDDELMEMBER_OK = 759;
  SM_GUILDDELMEMBER_FAIL = 760;
  SM_GUILDRANKUPDATE_FAIL = 761;
  SM_BUILDGUILD_OK = 762;
  SM_BUILDGUILD_FAIL = 763;
  SM_DONATE_OK = 764;
  SM_DONATE_FAIL = 765;

  SM_766 = 766; //?????????
  SM_MENU_OK = 767; //?
  SM_GUILDMAKEALLY_OK = 768;
  SM_GUILDMAKEALLY_FAIL = 769;
  SM_GUILDBREAKALLY_OK = 770; //?
  SM_GUILDBREAKALLY_FAIL = 771; //?
  SM_DLGMSG = 772; //Jacky
  SM_SPACEMOVE_HIDE = 800;
  SM_SPACEMOVE_HIDE2 = 800; //806
  SM_SPACEMOVE_SHOW = 801;
  SM_SPACEMOVE_SHOW2 = 801; //807

  SM_RECONNECT = 802; //
  SM_GHOST = 803;
  SM_SHOWEVENT = 804;
  SM_HIDEEVENT = 805;


  SM_TIMECHECK_MSG = 810;
  SM_ADJUST_BONUS = 811; //?

  SM_OPENHEALTH = 1100;
  SM_CLOSEHEALTH = 1101;

  SM_BREAKWEAPON = 1102;
  SM_INSTANCEHEALGUAGE = 1103; //??
  SM_CHANGEFACE = 1104;
  SM_VERSION_FAIL = 1106;

  SM_ITEMUPDATE = 1500;
  SM_MONSTERSAY = 1501;
  SM_CRSHIT = 10014;
  SM_GAMEGOLDNAME = 59001; //? 10015                //���� 59001
  SM_SERVERCONFIG = 10016; //?

  SM_MAGADDABILTY = 21292; //w1=1 ��ջ���           //���� 21292
                                 // w1=2  ��Ӱ��
                                 // w1=3  1+2
                                 // w1=4  ����

  SM_EXCHGTAKEON_OK = 65023;
  SM_EXCHGTAKEON_FAIL = 65024;


  SM_TEST = 65037;
  SM_THROW = 65069;


  RM_DELITEMS = 9000; //Jacky
  RM_TURN = 10001;
  RM_WALK = 10002;
  RM_RUN = 10003;

  RM_HIT = 10004;
  RM_HEAVYHIT = 10005;
  RM_BIGHIT = 10006;
  RM_SPELL = 10007;
  RM_SPELL2 = 10008;
  RM_POWERHIT = 10009;
  RM_MOVEFAIL = 10010;
  RM_LONGHIT = 10011;
  RM_WIDEHIT = 10012;
  RM_PUSH = 10013;
  RM_PUSHx = 11116;
  RM_FIREHIT = 10014;
  RM_CRSHIT = 10018;
  RM_29 = 29;
  RM_41 = 41;
  RM_59 = 59;
  RM_60 = 60;
  RM_47 = 47;
  RM_RUSH = 10015;

  RM_RUSHKUNG = 10016;
  RM_HORSERUN = 10017;

  RM_STRUCK = 10020;
  RM_DEATH = 10021;
  RM_DISAPPEAR = 10022;
  RM_MAGSTRUCK = 10025;
  RM_MAGHEALING = 10026;
  RM_STRUCK_MAG = 10027;
  RM_MAGSTRUCK_MINE = 10028;
  RM_INSTANCEHEALGUAGE = 10029; //jacky
  RM_HEAR = 10030;
  RM_WHISPER = 10031;
  RM_CRY = 10032;
  RM_RIDE = 10033;
  RM_WINEXP = 10044;
  RM_USERNAME = 10043;
  RM_LEVELUP = 10045;
  RM_CHANGENAMECOLOR = 10046;
  RM_MENU_OK = 10077; //?
  RM_MERCHANTDLGCLOSE = 10048; //?
  RM_SENDDELITEMLIST = 10049; //?

  RM_LOGON = 10050;
  RM_ABILITY = 10051;
  RM_HEALTHSPELLCHANGED = 10052;
  RM_DAYCHANGING = 10053;
  RM_ALIVE = 10055; ///?

  RM_SENDGOODSLIST = 645;
    RM_SENDFASTGOODSLIST = 6451;
  RM_SENDUSERSELL = 646;
  RM_USERMAKEDRUGITEMLIST = 712;
  RM_USERSTORAGEITEM = 700;
 // RM_USERGETBACKITEM     =  1032;
//  RM_SPACEMOVE_FIRE      = 1033;
  RM_BUYITEM_SUCCESS = 650;
  RM_BUYITEM_FAIL = 651;
  RM_SENDDETAILGOODSLIST = 652;
  RM_SENDUSERREPAIR = 668;
  RM_SENDBUYPRICE = 647;
  RM_USERSELLITEM_OK = 648;
  RM_USERSELLITEM_FAIL = 649;
  RM_MAKEDRUG_SUCCESS = 2092;
  RM_MAKEDRUG_FAIL = 2093;
  RM_SENDREPAIRCOST = 2080;
  RM_SENDUSERSREPAIR = 2079;
  RM_USERREPAIRITEM_FAIL = 2082;
  RM_USERREPAIRITEM_OK = 2081;

  RM_ADJUST_BONUS = 811;

  RM_BUILDGUILD_OK = 762;
  RM_BUILDGUILD_FAIL = 763;
  RM_DONATE_OK = 2139;
  RM_GAMEGOLDCHANGED = 2189; //?
  RM_SPACEMOVE_SHOW2 = 2190;
  RM_MYSTATUS = 2191;
  RM_DELAYPUSHED = 2192;






//////////////////
  RM_SYSMESSAGE = 10100;
  RM_10101 = 10101;
  RM_GROUPMESSAGE = 10102;
  RM_SYSMESSAGE2 = 10103;
  RM_GUILDMESSAGE = 10104;
  RM_SYSMESSAGE3 = 10105; //Jacky
  RM_ITEMSHOW = 10110;
  RM_ITEMHIDE = 10111;
  RM_DOOROPEN = 10112;
  RM_DOORCLOSE = 10113;
  RM_SENDUSEITEMS = 10114;
  RM_WEIGHTCHANGED = 10115;
  RM_FEATURECHANGED = 10116;
  RM_CLEAROBJECTS = 10117;
  RM_CHANGEMAP = 10118;
  RM_BUTCH = 10119;
  RM_MAGICFIRE = 10120;
  RM_MAGICFIREFAIL = 10121;
  RM_SENDMYMAGIC = 10122;
  RM_MAGIC_LVEXP = 10123;
  RM_SKELETON = 10024;
  RM_DURACHANGE = 10125;
  RM_MERCHANTSAY = 10126;
  RM_GOLDCHANGED = 10136;
  RM_CHANGELIGHT = 10137;

  RM_LAMPCHANGEDURA = 10138;
  RM_CHARSTATUSCHANGED = 10139;
  RM_GROUPCANCEL = 10140;


  RM_POISON = 10141; //?�ж�
//  RM_SPACEMOVE_FIRE2    = 10142; //?
  RM_CHANGEGUILDNAME = 10143; //?
  RM_USERGETBACKITEM = 10147; //ok
  RM_DELAYMAGIC = 10154;
//  RM_DELAYPUSHED        = 10155;
  RM_10155 = 10155;

  RM_DIGUP = 10200;
  RM_DIGDOWN = 10201;
  RM_FLYAXE = 10202;
  RM_LIGHTING = 10204;
  RM_10205 = 10205;
  rm_10206 = 10206;

  RM_SUBABILITY = 10302;
  RM_DONATE_FAIL = 10306;
  RM_TRANSPARENT = 10308;

  RM_SPACEMOVE_FIRE = 10330;
  RM_SPACEMOVE_FIRE2 = 10330;
  RM_SPACEMOVE_SHOW = 10331;
  RM_RECONNECTION = 10332;
  RM_HIDEEVENT = 10333;
  RM_SHOWEVENT = 10334;
  RM_ZEN_BEE = 10337;

  RM_10401 = 10401;
  RM_OPENHEALTH = 10410;
  RM_CLOSEHEALTH = 10411;
  RM_DOOPENHEALTH = 10412;
  RM_BREAKWEAPON = 10413;
  RM_10414 = 10414;
  RM_CHANGEFACE = 10415;
  RM_PASSWORD = 10416;
  RM_PLAYDICE = 10500;
  RM_PASSWORDSTATUS = 10501;


  RM_ITEMUPDATE = 11000;
  RM_MONSTERSAY = 11001;
  RM_MAKESLAVE = 11002;

  RM_SPYMOVE = 11003;
  RM_TAKEHORSE = 11004;
  RM_MAGADDABILTY = 11005;
  RM_21292 = 21292;
  RM_SELLITEM = 21293;
  RM_PetSellItem=32982;
  rm_8941 = 21294;
  rm_8942 =9999;
  Rm_768=19768;
  RM_ColorMsg=19769;
  rm_21295 = 21295;
  RM_FUSHEN = 21296;
  RM_510 = 21297;
  RM_YSStart = 21298;
  RM_dengyu1 = 21299;
  RM_ANYING = 21300;
  RM_ZUOYI = 21301;
  RM_25 = 21302;
  RM_linghunqiang = 21303;
  RM_linghunqiang2 = 21304;
  RM_YSSKILL = 21305;
  RM_3082=23082;
  RM_3046=23046;
type
  TIntRec=record
    case Byte of
    0: (Value:Integer);
    1: (btValue:array[0..3] of Byte;)
  end;
  pTEvilMonAppr=^TEvilMonAppr;
  TEvilMonAppr=record
     nAppr       : Integer;
     nJob        : Integer;
     nSex        : Integer;
     nHair       : Integer;
     nRealm      : Integer;
     nWings      : Integer;
     sUserItem   : array[0..12] of string[30];
     sMagic      : array[0..19] of string[30];

  end;

  TGList = class(Tlist)
  private
    CriticalSection: TRTLCriticalSection;
   // 	CSTGLIST: TRTLCriticalSection;         EnterCriticalSection(CriticalSection);
  public
    constructor Create;
    destructor Destroy; override;
    procedure lock;
    procedure unlock;
 //   function  GetIndex(sName:String):Integer;
 //   function  AddRecord(sName:String;nIndex:Integer):Boolean;
  end;


  TGStringList = class(TStringlist)
  private
    CriticalSection: TRTLCriticalSection;
  public
    constructor Create;
    destructor Destroy; override;
    procedure lock;
    procedure unlock;

  end;
  TQuestUnit = array[0..47] of byte;
  TQuestFlag = array[0..47] of byte;

  TIPaddr = record
    sIpaddr: string[15];
    dIPaddr: string[15];
  end;
  TMsgType =
    (t_Notice, t_Hint, t_System, t_Say, t_Mon, t_GM, t_Cust, t_Castle, t_hSystem, t_rSystem, t_tSystem,t_topSystem);

  pTquestion=^TQuestion;
  TQuestion=record
    sId : string;
    sQuestion : String;
    sAnswer   : array[0..6] of String;
    sAnswerOK   : string;
  end;

  pTDelayCall=^TDelaycall;
  TDelayCall=record
    sLabel:String;
    Npc:Tobject;
    m_nDelayTime:LongWOrd;
    m_dwnnpcdelaytick :LongWord;
    m_nDelayCallCount:Integer;
  end;
  TClassProc = procedure(Sender: TObject); //of object
  _GetTime = function: TDateTime;
  _ENcode = function(sour, Key: string; Count: Integer; boUseMainKey: Boolean): Pchar;
  _HardID = function: PChar;
  _GetCrc = function(FileName: string): Pchar;
  _ComparHard = function(oldStr, NewStr: string): PChar;
  _Init = procedure(H: Integer; MFileName, FileName: pchar);

  TIPLocal = procedure(sIPaddr: PChar; sLocal: PChar;nLength: Integer)stdcall ;

  TGameDataLog = function(LogMsg: PChar; nLen: Integer):
    Boolean stdcall;

  TDeCryptString = procedure(Src: PChar; Dest: PChar;
    nSrc: Integer; skey: string; var nDest: Integer) stdcall;


 //TCheckVersion=pointer ;
  TCheckVersion = function(nVersion: Integer): Boolean stdcall;

  TProcInfo = record
    nProcAddr: Pointer;
    sProcName: string[30];
  end;

  pTProcInfo = ^TProcInfo;

  TObjectInfo = record
    Obj: TObject;
    sObjcName: string[30];
  end;
  TProcArray = array[0..99] of TProcInfo;

  TObjectArray = array[0..99] of TObjectInfo;

  pTProcArray = ^TProcArray;

 // TMsgProc=   procedure(Msg:PChar;nMsgLen:Integer;nMode:Integer);stdcall;
  TMsgProc = procedure(Msg: PChar; nMsgLen: Integer;
    nMode: Integer); stdcall;


//  TFindProc=  function(ProcName:PChar;nNameLen:Integer):Pointer;stdcall;
  TFindProc = function(sProcName: PChar; nNameLen: Integer):
    Pointer; stdcall;

  //  TSetProc=  function (ProcAddr:Pointer;ProcName:PChar;nNameLen:Integer):Boolean;stdcall  ;
  TSetProc = function(ProcAddr: Pointer; ProcName: PChar;
    nNameLen: Integer): Boolean; stdcall;



//  TFindObj = function   (ObjName:PChar;nNameLen:Integer):TObject;stdcall;
  TFindObj = function(sObjName: PChar; nNameLen: Integer):
    TObject; stdcall;


//  TPlugInit=  function(AppHandle:HWnd;MsgProc:TMsgProc;FindProc:TFindProc;SetProc:TSetProc;FindObj:TFindObj):PChar; stdcall;
  TPlugInit = function(AppHandle: HWND; MsgProc: TMsgProc;
    FindProcTable: TFindProc; SetProc: TSetProc; FindObj: TFindObj):
    PChar; stdcall;

  TSendBroadCastMsg = procedure(Msg: PChar; MsgType: TMsgType);
  stdcall;

 // TGetRGB=function(c256: Byte): TColor ;stdcall;




  TCheckCode = record
    dwThread0: LongWord;
    sThread0: LongWord;
  end;


  TLXBHInfo = packed  record
    sName   : string[14];               //0..14
    btmemo  : array[15..25] of Byte;

    nTime1  : Integer;
    nTIme2  : Integer;
    //nTime   : TDateTime ; // 26..33
    btmemo1  : array[34..47] of Byte;
    btItemCOunt : Byte;
    HeziCOunt   : Byte;
    HZCount     : Byte;
     btmemo2  : array[51..67] of Byte;
  end;

  TMonGenInfo = record
    sMapName: string[14];
    nX: Integer;
    nY: Integer;
    sMonName: string[14];
   // nAreaX       :Integer;
   // nAreaY       :Integer;
    nCount: Integer;
    dwZenTime: LongWord;
    nRange: integer;
    nMissionGenRate: integer;
    CertList: tlist;
    Envir: TObject; // TEnvirnoment; //
    nRace: Integer;
    dwStartTick: LongWord;
    sMonNewName:string[20];
    nLevel     :Integer;
  end;
  pTMonGenInfo = ^TMonGenInfo;


  TProgamType = (tDBServer, tLoginSrv, tLogServer, tM2Server, tLoginGate, tLoginGate1, tSelGate, tSelGate1,
    tRunGate, tRunGate1, tRunGate2, tRunGate3, tRunGate4, tRunGate5, tRunGate6, tRunGate7);

  TVarType = (vInteger, vString, vNone);

  TDynamicVar = record
    sName: string;
    VarType: TVarType;
    nInternet: integer;
    sString: string;
  end;
  pTDynamicVar = ^TDynamicVar;

  TItemName = record
    nMakeIndex: integer;
    nItemIndex: integer;
    sItemName: string;
  end;
  pTItemName = ^TItemName;


  TSessInfo = record
    sAccount: string[14];
    sIPaddr: string[15];
    nSessionID: integer;
    nPayMent: integer;
    nPayMode: integer;
    nSessionStatus: integer;
    dwStartTick: LongWord;
    dwActiveTick: LongWord;
    nRefCount: integer;
  end;
  pTSessInfo = ^TSessInfo;



  TGateInfo = record
    boUsed: boolean;
    Socket: TCustomWinSocket;
    sAddr: string[20];
    nPort: integer;
    n520: integer;
    UserList: TList;
    nUserCount: integer;
    Buffer: pchar; //array[0..2000]of char;
    nBuffLen: integer;
    BufferList: TList;
    boSendKeepAlive: boolean;
    boSendCheckPro: boolean; //�Ƿ��Ѿ���������רҵ�汾��֤
    dwSendCheckProTick: LongWord;
    nSendChecked: integer;
    nSendBlockCount: integer;
    nSendMsgCount: integer;
    nSendRemainCount: integer;
    dwSendTick: LongWord;

    nSendMsgBytes: integer;
    nSendedMsgCount: integer;
    nSendBytesCount: integer;
    nSendCount: integer;
    dwSendCheckTick: LongWord;

    dwTime544: LongWord;
  end;
  pTGateInfo = ^TGateInfo;




  TMagic =packed record //ħ��
    wMagicID: Word; //���
 //   Num:byte;          //����ӦΪMagicName:Array[0..13] of char //num �����Լ��ӵ�,��ʾ�������ֵ���Ч�ַ���.
    sMagicName: string[12]; //Array[0..12] of Char;   //���� 12
     //Ч��
    btEffectType: BYTE;
    btEffect: BYTE;
    xx: Byte;
    wSpell: Word; //ħ��
    wPower: Word;


    TrainLevel: array[0..5] of BYTE; //������Ҫ�ĵȼ�
    MaxTrain: array[0..3] of Integer; //����
    btTrainLv: BYTE; //�������ȼ�
    btJob: BYTE;
    wmemo:Word;
    dwDelayTime: dword; //�ӳ�ʱ��
    btDefSpell: BYTE; //Ĭ��
    btDefPower: BYTE;
    wMaxPower: Word; //
    btDefMaxPower: BYTE;
    btMemo:Byte;
    btLenvel:Byte;
    btDesc:array[0..16] of Byte;
 //   sDescr: string[16]; //Array[0..15] of Char;
  end;
  pTMagic = ^TMagic;

  TCLIENTMAGIC =packed record //ħ��        84
    Key: Char; //����
    level: byte; //�ȼ�
    bt1,bt2:Byte;
    CurTrain: integer; //��ǰ����
    
    Def: TMagic;
  end;

  TMagicInfo = record
    wMagicID: Word; //���
 //   Num:byte;          //����ӦΪMagicName:Array[0..13] of char //num �����Լ��ӵ�,��ʾ�������ֵ���Ч�ַ���.
    sMagicName: string[12]; //Array[0..12] of Char;   //���� 12

    btEffectType: BYTE;
    btEffect: BYTE; //Ч��
    xx: Byte;
    wSpell: Word; //ħ��
    wPower: Word;


    TrainLevel: array[0..3] of BYTE; //������Ҫ�ĵȼ�
    MaxTrain: array[0..3] of Integer; //����
    btTrainLv: BYTE; //�������ȼ�
    btJob: BYTE;
    dwDelayTime: dword; //�ӳ�ʱ��
    btDefSpell: BYTE; //Ĭ��
    btDefPower: BYTE;
    wMaxPower: Word; //
    btDefMaxPower: BYTE;
    sDescr: string[15]; //string[15];//Array[0..15] of Char;
  end;
  pTMagicInfo = ^TMagicInfo;
  pTUnit_Item=^TUnit_Item;
  TUnit_Item=packed record
    Name          : string[20];
    ItemName      : array[0..13] of string[20];
    sTakeOn       : string[20];
    sTakeOff      : string[20];
    sTakeOnHint   : String[200];
    boTwoARMRING  : Boolean;
    boTwoRing     : Boolean;
    boParalysis   : Boolean;
    boMagicShield : Boolean;
    boRevival     : Boolean;
    boTeleport    : Boolean;
    boProbeNecklace  : Boolean;
    boMuscleRing   : Boolean;//����
    boFastTrain    : Boolean;
    boTransparent  : Boolean;  //����
    btHP          : Byte;
    btMp          : Byte;
    btAC1,btAC2   : Byte;
    btDC1,btDC2   : Byte;
    btMAC1,btMAC2 : Byte;
    btSC1,btSC2   : Byte;
    btMC1,btMC2   : Byte;
    btHit,btSpeed : Byte;
    btAntiMagic   : Byte;
    btAntiPoison  : Byte;
  end;
  TUserMagic = packed record //     for m2       packed
    wMagIdx: word;
    btLevel: byte;
    btKey: byte;
    nTranPoint: integer;
    MagicInfo: pTMagic;
   // UserMagic:TMagicInfo;
  end;
  pTUserMagic = ^TUserMagic;

  THmagic = packed record //dbs
    wMagIdx: word;
    btLevel: byte;
    btKey: byte;
    nTranPoint: integer;
  end;

 // 2009-2-20 20:53:23  ��ħ��ɱ���ݽṹ
 TEvilKillDate=packed  record
    nZMValueMax : Integer;
    nValue2 : Integer;
    nMonID  : Integer;
    wValue1 : Word;
    wValue2 : Word;
    btValue : array[0..12] of Byte;
 End;

  TGoldChangeInfo = record
    sGameMasterName: string[14];
    sGetGoldUser: string[14];
    nGold: integer;
  end;
  pTGoldChangeInfo = ^TGoldChangeInfo;

  TLoadDBInfo = record
    nGateIdx: integer;
    nSocket: integer;
    sAccount: string[12];
    sCharName: string[14];
    sIPaddr: string[15];
  //LoadRcdInfo.boClinetFlag     := boFlag;
    nSessionID: integer;
    nSoftVersionDate: integer;
    nPayMent: integer;
    nPayMode: integer;

    nGSocketIdx: integer;

    dwNewUserTick: dword;
    PlayObject: TObject;
    nReLoadCount: integer;
    boLoadLocalIp: boolean;
    boYs:Boolean;
  end;
  pTLoadDBInfo = ^TLoadDBInfo;



  Tonhorse = record
    nw1: integer;
    nw2: integer;
    nw3: integer;
  end;


  TGameCmd = record
    sCmd: string[20];
    nPerMissionMin: integer;
    nPerMissionMax: integer;
     // nPermissionMin:integer;
  end;
  pTGameCmd = ^TGameCmd;



  TDefaultMessage = record
    Recog: Integer;
    Ident: Word;
    Param: Word;
    Tag: Word;
    Series: Word;
  end;
  pTDefaultMessage = ^TDefaultMessage;


  TSlaveInfo = record
    sSalveName: string[14];
    btSalveLevel: byte;
    dwRoyaltySec: dword;
    nKillCount: integer;
    btSlaveExpLevel: byte;
    nHP: integer;
    nMP: integer;
  end;
  pTSlaveInfo = ^TSlaveInfo;

  TQuestInfo = record
    wFlag: WORD;
    btValue: byte;
    nRandRage: integer;


  end;

  TScript = record
    nQuest: integer;
    boQuest: boolean;
    RecordList: tlist;
    QuestInfo: array[0..9] of TQuestInfo;
  end;
  pTScript = ^TScript;

   TBaoZiInfo=record
     nMakeIndex         : Integer;      //��ʯID
     M_MonPetColor      : Integer;      //������ɫ
     M_monsterZSD       : Integer;
     M_monsterExp       : Integer;
     m_boPetOnSell      : Boolean;      //�Ƿ��̯��
     m_boBaoZiAttacked  : Boolean;      //�Ƿ���ս
     m_boOnBaozi        : Boolean;      //�Ƿ���
   end;






  TMsgColor = (c_Red, c_Green, c_Blue, c_White, c_fengs,c_Yellow);
//  TMsgColor=record
//  end;



//  TMsgType=(t_Mon,t_Hint,t_GM,t_System,t_Notice,t_Cust,t_Castle,t_Say,t_hSystem) ;


  TMonStatus = (s_KillHuman, s_UnderFire, s_Die, s_MonGen);


 // end;

  //   THumanUseItems=record
   //  end;



  TStatusTime = array[0..15] of integer; //   0..11

  Tm2StatusTime = array[0..11] of integer;

  TAddAbility = record //OK    //Size 40
    Level: Byte; //0x198  //0x34
    bt035: Byte;
    wAC: dWord; //0x19A  //0x36
    wMAC: dWord; //0x19C  //0x38
    wDC: dWord; //0x19E  //0x3A
    wMC: dWord; //0x1A0  //0x3C
    wSC: dWord; //0x1A2  //0x4E
    wHP: Word; //0x1A4  //0x40
    wMP: Word; //0x1A6  //0x42
    MaxHP: Word; //0x1A8  //0x44
    MaxMP: Word; //0x1AA  //0x46
 //   dw1AC         :Dword;  //0x1AC  //0x48
    Exp: Dword; //0x1B0  //0x4C
    MaxExp: Dword; //0x1B4  //0x50
    Weight: Word; //0x1B8   //0x54
    MaxWeight: Word; //0x1BA   //0x56
    WearWeight: word; //Byte;  //0x1BC   //0x58
    MaxWearWeight: word; //Byte;  //0x1BD   //0x59
    HandWeight: word; //Byte;  //0x1BE   //0x5A
    MaxHandWeight: word; //Byte;  //0x1BF   //0x5B
    btWeaponStrong: Byte;
    bt1DF: Byte;
    wHitPoint: Word;
    wSpeedPoint: Word;

    wAntiPoison: Word;
    wPoisonRecover: Word;
    wHealthRecover: Word;
    wSpellRecover: Word;
    wAntiMagic: dword;
    btLuck: Byte;
    btUnLuck: Byte;
    nHitSpeed: integer;

  end;


  TNakedAbility = record
   case byte of
   0:(
    DC: word;
    MC: word;
    SC: word;
    AC: word;
    MAC: word;
    HP: word;
    MP: word;
    Hit: word;
    Speed: word;
    X2: word;
    );
    1:(
      wValue:array[1..10] of word;
     )
  end;
  pTNakedAbility = ^TNakedAbility;

  TSUBABILITYDATA = packed record
    nActive: word;
    nActiveMax: word;
    color: byte; //integer
    jpactive: integer; //word
    ubyte: byte;
    btvalue1:Byte;   //��������
    btvalue2:Byte;
    btvalue3:Byte;
    btvalue4:Byte;
 // jpactivemax    :word;
  end;

  TMapflag = record
    nMUSICID: integer;
    nL: integer;
  //  boSAFE:boolean;
 //   boDARK:boolean;
    boFIGHT: boolean;
    boFIGHT3: boolean;
 //   boDAY:boolean;
    sReConnectMap: string[14];
    boMUSIC: boolean;
    boEXPRATE: boolean;
    nEXPRATE: integer;
    nPKWINLEVEL: integer;
    nPKWINEXP: integer;
    nPKLOSTLEVEL: integer;
    nPKLOSTEXP: integer;
    boDECHP: boolean;
    nDECHPPOINT: integer;
    nDECHPTIME: integer;
    boINCHP: boolean;
    nINCHPPOINT: integer;
    nINCHPTIME: integer;
    boDECGAMEGOLD: boolean;
    nDECGAMEGOLD: integer;
    nDECGAMEGOLDTIME: integer;
    boDECGAMEPOINT: boolean;
    nDECGAMEPOINT: integer;
    nDECGAMEPOINTTIME: integer;
    boINCGAMEGOLD: boolean;
    nINCGAMEGOLD: integer;
    nINCGAMEGOLDTIME: integer;
    boINCGAMEPOINT: boolean;
    nINCGAMEPOINT: integer;
    nINCGAMEPOINTTIME: integer;
    boRUNHUMAN: boolean;
    boRUNMON: boolean;
    boNEEDHOLE: boolean;
    boNORECALL: boolean;
    boCANRECALLEVIL:Boolean;
    boNOGUILDRECALL: boolean;
    sMapFucx:String;
    boNODEARRECALL: boolean;
    boNOMASTERRECALL: boolean;
    boNORANDOMMOVE: boolean;
    boNODRUG: boolean;
    boMINE: boolean;
    boNODOSHOP:Boolean;
    
    boPKWINLEVEL: boolean;

    boPKWINEXP: boolean;
    boPKLOSTLEVEL: boolean;
    boPKLOSTEXP: boolean;

  //   nL                   :integer;

    // nNeedONOFF:integer;
    nRequestLevel: Integer; //0x18 ���뱾��ͼ����ȼ�
    nWidth: Integer; //0x1C
    nHeight: Integer; //0x20
    boDARK: Boolean; //0x24
    boDAY: Boolean; //0x25
    boDarkness: Boolean;
    boDayLight: Boolean;
    DoorList: TList; //0x28
    bo2C: Boolean;
    boSAFE: Boolean; //0x2D
    boCANHORSE: Boolean; //������
    boNOBATFLY: Boolean; //����ʹ�� ����
    boCanUseLF: Boolean;
    boNOYS: Boolean;
    boNOQB: Boolean;
     m_sDelayCall:string;
    m_nDelayCallTime:Integer;
    boFightZone: Boolean; //0x2E
    boFight3Zone: Boolean; //0x2F  //�л�ս����ͼ
    boQUIZ: Boolean; //0x30
    boNORECONNECT: Boolean; //0x31
    boNOPOSITIONMOVE: Boolean; //0x37
    sNoReconnectMap: string[14]; //0x38
    QuestNPC: TObject; //0x3C
    nNEEDSETONFlag: Integer; //0x40
    nNeedONOFF: Integer; //0x44
    m_QuestList: TList; //0x48
    m_boRUNHUMAN: Boolean; //���Դ���
    m_boRUNMON: Boolean; //���Դ���
    m_boINCHP: Boolean; //�Զ���HPֵ
    m_boINCGAMEGOLD: Boolean; //�Զ�����Ϸ��
    m_boINCGAMEPOINT: Boolean; //�Զ��ӵ�
    m_boDECHP: Boolean; //�Զ���HPֵ
    m_boDECGAMEGOLD: Boolean; //�Զ�����Ϸ��
    m_boDECGAMEPOINT: Boolean; //�Զ�����
    m_boMUSIC: Boolean; //����
    m_boEXPRATE: Boolean; //ɱ�־��鱶��
    m_boPKWINLEVEL: Boolean; //PK�õȼ�
    m_boPKWINEXP: Boolean; //PK�þ���
    m_boPKLOSTLEVEL: Boolean; //PK���ȼ�
    m_boPKLOSTEXP: Boolean; //PK������
    m_nPKWINLEVEL: Integer; //PK�õȼ���
    m_nPKLOSTLEVEL: Integer; //PK���ȼ�
    m_nPKWINEXP: Integer; //PK�þ�����
    m_nPKLOSTEXP: Integer; //PK������
    m_nDECHPTIME: Integer; //��HP���ʱ��
    m_nDECHPPOINT: Integer; //һ�μ�����
    m_nINCHPTIME: Integer; //��HP���ʱ��
    m_nINCHPPOINT: Integer; //һ�μӵ���
    m_nDECGAMEGOLDTIME: Integer; //����Ϸ�Ҽ��ʱ��
    m_nDECGAMEGOLD: Integer; //һ�μ�����
    m_nDECGAMEPOINTTIME: Integer; //����Ϸ����ʱ��
    m_nDECGAMEPOINT: Integer; //һ�μ�����
    m_nINCGAMEGOLDTIME: Integer; //����Ϸ�Ҽ��ʱ��
    m_nINCGAMEGOLD: Integer; //һ�μ�����
    m_nINCGAMEPOINTTIME: Integer; //����Ϸ�Ҽ��ʱ��
    m_nINCGAMEPOINT: Integer; //һ�μ�����
    m_nMUSICID: Integer; //����ID
    m_nEXPRATE: Integer; //���鱶��
    m_nMonCount: Integer;
    m_nHumCount: Integer;
    mirrorname: string[14];
    m_weatherEffect: integer;
    m_WindSpeed:Integer;
    m_WinsColor:Integer;
    m_nQfunction: integer;

    m_skillbyhumlabel: string[20];
    m_skillbymonlabel: string[20];

    m_skillhumlabel: string[20];
    m_skillmonlabel: string[20];
    m_slevelupgotolabel: string[20];
    m_sCanUserItem:string ;
    m_sNotAllowUseItem:string;
    m_sNotAllowUseMagic:string ;

  end;



  pTMapFlag = ^TMapflag;

  TDoorStatus = record
    boOpened: boolean;
    bo01: boolean;
    n04: integer;
    dwOpenTick: dWord;
    nRefCount: integer;

  end;
  pTDoorStatus = ^TDoorStatus;

  pTNewMapEvent=^TNewMapEvent;
  TNewMapEvent=record
     nSign            : Integer;
     btcondition      : Byte;
     sConditionItem   : string[16];
     boconditionGroup : Boolean;
     nRate            : Integer;
     sLabel           : string;
  end;



  TMessageBodyW = record
    Param1: word; //integer;
    Param2: word; //integer;
    Tag1: word; //integer;
    Tag2: word; //integer;
  end;
  TYsOnBaozi=packed  record
    Feature:Integer;
    btAttack:Byte;
  end;
  TmyCharDesc = record
    Feature: Integer;
    Status: Integer;
    xue: integer; //hint 11.23  ��ɫ��Ѫ��
  end;
  TYSfenghao = packed record

    b1: Integer;  //����˵������������ϳ���Ī������ͼƬ��bug
    n1: integer;
  end;

  TmyszCharDesc = record
    Feature: Integer;
    Status: Integer;
    stop: word; //ʨ�Ӻ������
  end;

  TSpyFly = record
//  nw1:integer;
//  nw2:integer;
//  nw3:integer;
    chardesc: TmyCharDesc;
    wsx: word;
    wsy: word;
    ww4: word;
    wflag: word; // wflag:=0; //��ʾ ���� //77 ����  //75 �ݵ�
    stext: array[0..31] of char;
  end;


  TCharDesc = record
    Feature: Integer;
    Status: Integer;
    xue: integer; //hint 11.23  ��ɫ��Ѫ��
  end;

  TMessageBodyWL = record
    lParam1, lParam2: integer; //longint;
    lTag1, lTag2: integer; //longint;
  end;


  TShortMessage = record
    Ident: integer;
    wMsg: integer;
  end;

  TDoorInfo = record
    nX: integer;
    nY: integer;
    n08: integer;
    Status: pTDoorStatus;

  end;
  pTDoorInfo = ^TDoorInfo;

  TProcessMessage = record
    wIdent: word; //cmd
    wParam: word; //w3
    BaseObject: TObject;
    nParam1: integer; //flag
    nParam2: integer; //w1
    nParam3: integer; //w2
    dwDeliveryTime: dword;
    boLateDelivery: boolean;
    sMsg: string;

  end;
  pTProcessMessage = ^TProcessMessage;

  TCharDress = packed record
    bt: byte;
    dress: integer;
  end;



 /////////////////////////////////////////////////

  TSrvNetInfo = record
    sIPaddr: string[15];
    nPort: Integer;
  end;
  pTSrvNetInfo = ^TSrvNetInfo;
TPetAddProperty=packed record
    nMakeIndex      : Integer;
    wCount          : Word;
    btZizhi         : Byte;
    wHp             : Word;
    btMagic         : Byte;
    btANTIPOISON    : Byte;          //6  �ж����
    btMAC1          : Byte;          //7 ǰ3����Ϊ ħ����������  ��5����Ϊ     ħ������
    btMAC2          : Byte;          //8 ǰ3����Ϊ ħ����������   ��5����Ϊħ������
    btMAGICNICETY   : Byte;          //9 ǰ3����Ϊ ������������   ��5����Ϊ ħ������
    btEVADET        : Byte;          //10  ǰ3����Ϊ   ����   ��5����Ϊ  ���
    btAC1           : Byte;          //11 ǰ3����Ϊ��������    ��5����Ϊ  ��������
    btAC2           : Byte;          //12 ǰ3����Ϊ ��������   ��5����Ϊ ��������
    btANTIMAGIC     : Byte;          //13 ǰ3����Ϊ ������������   ��5����Ϊ   ħ�����
    btPOISONNICETY  : Byte;          //14 ǰ1����Ϊ  �ƶ��ٶ�  2��3����Ϊ ����  ��5����Ϊ�ж�����
    btSAVVY         : Byte;          //15����
    btvalue1         : Byte;         //ǰ2����Ϊ ������������  (0: ��1:ľ��2:����3:ˮ) ��������Ϊ��������ֵ
    btvalue2         : Byte;         //ǰ2����Ϊ ������������  (0: ��1:ľ��2:����3:ˮ) ��������Ϊ��������ֵ
    btvalue3         : Byte;
    btvalue4         : Byte;
  end;

   //��ħ���Խṹ
 pTAttachMagicRCD1=^TAttachMagicRCD1;
   TAttachMagicRCD1 =packed record
    case Byte of
      0:(
    MakeIndex         :Integer;   //MakeIndex
    B5       :Byte;
    B6       :Byte;
    B7       :Byte;
    B8       :Byte;
    MercenaryName     :array[0..13] of char;
    B23       :Byte;
    B24       :Byte;
    MercenaryJob      :BYTE;		//Ԫ��ְҵ(��ʿ:0   ��ʦ:1   ��ʿ:2)
    MercenaryState    :BYTE;	  //Ԫ�񾳽�  (0-3 3�����к���Ч��)
    DC                :WORD;		// +����
	  MAC               :WORD;	  //+ħ��
	  SC                :WORD;	  //+����
    ZMValue           :WORD;	  //��ħֵ
    MC                :Word;
    AC                :Word;
    bFlag     :Byte;    //(1:��  2:��)
    B40       :Byte;

    );
    1:(b:array[0..15] of Byte;
    PetAddProperty:TPetAddProperty;
    )
  end;
//  pTAttachMagicRCD=^TAttachMagicRCD;
   TAttachMagicRCD =packed record
    case Byte of
      0:(

    MakeIndex         :Integer;   //MakeIndex
    B5       :Byte;
    B6       :Byte;
    B7       :Byte;
    B8       :Byte;
    MercenaryName     :array[0..13] of char;
    B23       :Byte;
    B24       :Byte;
    MercenaryJob      :BYTE;		//Ԫ��ְҵ(��ʿ:0   ��ʦ:1   ��ʿ:2)
    MercenaryState    :BYTE;	  //Ԫ�񾳽�  (0-3 3�����к���Ч��)
    DC                :WORD;		// +����
	  MAC               :WORD;	  //+ħ��
	  SC                :WORD;	  //+����
    ZMValue           :WORD;	  //��ħֵ
    MC                :Word;
    AC                :Word;
    bFlag     :Byte;    //(1:��  2:��)
    B40       :Byte;

    );
    1:(
    aaa:TAttachMagicRCD1)
  end;


  TDarkProperty = packed record

    DMagic: Word; //�ڰ�ħ��
    B3: Byte; //δ֪
    B4: Byte; //δ֪
    btid: Byte; //δ֪
    B6: Byte; //δ֪
    DDC: Byte; //�ڰ�����(��λ��������, ��λ��������)
    DMC: Byte; //�ڰ�ħ��(��λ��������, ��λ��������)
    DSC: Byte; //�ڰ�����(��λ��������, ��λ��������)
    DAC: Byte; //�ڰ�����(��λ��������, ��λ��������)
    DMAC: Byte; //�ڰ�ħ��(��λ��������, ��λ��������)
    DNEEDLEVEL: Byte; //��Ҫ�ȼ�
    B14: Byte;
    B15: Byte;
    btMagicID: Byte;     //ʥ�龫��
    btMagicPower: Byte;
  end;
  pTItemDarkProperty = ^TItemDarkProperty;
  TItemDarkProperty = packed record
    nMakeIndex: Integer;
    nIdent: Integer;
    DarkProPerty: TDarkProperty;
  end;
  TStdItem = record //OK
    Name: string[14];
    StdMode: Byte;
    Shape: Byte;
    Weight: Byte;
    AniCount: Byte;
    Source: Shortint;
    Reserved: Byte;
    NeedIdentify: Byte;
    Looks        :Word;
    DuraMax: Word;
    AC: Word;
    MAC: Word;
    DC: Word;
    MC: Word;
    SC: Word;
    Need: Byte;
    NeedLevel: Byte;
    Price: Integer;
  end;
  pTStdItem = ^TStdItem;

  TSWYINFO=packed record
    btType   : Byte;
    btLevel  : Byte;
    str      : string[200];
  end;
  TOStdItem = record
    Name: string[14];
    StdMode: Byte;
    Shape: Byte;
    Weight: Byte;
    AniCount: Byte;
    Source: Shortint;
    Reserved: Byte;
    NeedIdentify: Byte;
    Looks: Word;
    DuraMax: Word;
    AC: Word;
    MAC: Word;
    DC: Word;
    MC: Word;
    SC: Word;
    Need: Byte;
    NeedLevel: Byte;
    Price: Integer;
  end;
  pTMsgInfo=^TMsgInfo;
  TMsgInfo=record
     Msg : String;
     Color:TColor ;
  end;
  pTPlantPoint=^TPlantPoint;
  TPlantPoint=record
    sMap  : string[100];
    x,y   : Integer;
    nRand : Integer;
  end;
  pTOStdItem = ^TOStdItem;
  TMonPetInfo=record
    Level    : Integer;
    montype  : Integer;
    MonLevel : Integer;
    MonColor : Integer;
    Exp      : Integer;
    ZSD      : Integer;
    FendTime : String;
  end;
  TPetInfo=packed record
    nMakeIndex : Integer;
    Name       : array[0..14] of char;
    btZSLevel   : Byte;  //�Ƿ�Ϊ̤�Ʊ�
    btLevel    : byte;
    wMemo      : Word;
    btColor    : Byte;
    time       : Integer;
    nMemo1     : Integer;//7
    nMemo2     : Integer;//0
    bb         : Byte;
    Hp         : Byte;
    ww         : Word;
    aMemo      : array[0..2] of Integer;
    wMemo1     : Word;
    wAttack    : Word;
    btd        : array[0..5] of byte;
  end;

  TBoxItem=packed record
    wLooks : Word;
    btDemo : Byte;
    SName  : string[14];
  end;
  TBoxIteminfo=packed record
    wLooks:Word;
    sName :array[0..13] of Char;
  end;
  PTClientItem = ^TClientItem;
  TClientItem = record //OK
    S: TStdItem;
    MakeIndex: Integer;
    Dura: Word;
    DuraMax: Word;
    DarkProperty: TDarkProperty;
  end;

  TcsClientItem = packed record //����װ���ṹ
    id: word;
    item: TClientItem;
  end;

  TUserStateInfo =packed record
    Feature: integer;
    UserName: string[15];
    NameColor: integer;
    GuildName: string[14];
    GuildRankName: string[15];
    sex: byte;
    UseItems: array[0..13] of TClientItem; //hint
 //   text:byte;
    text: array[0..70] of Byte;
  end;



  TClientSendModstyleName = packed record
    hander: array[0..19] of char;
    Name: array[0..79] of char;
  end;




  TMonInfo = record
    sName: string[14];
    btRace: Byte;
    btRaceImg: Byte;
    wAppr: Word;
    btLevel: Byte;
    btLifeAttrib: byte;
    dwExp: dword;
    wLevel: word;
    boUndead: Boolean;
    wCoolEye: Word;
    wExp: Word;
    wHP: Word;

    wMP: word;
    wAC: word;
    wMAC: word;
    wDC: word;
    wMaxDC: word;
    wMC: word;
    wSC: word;
    wSpeed: word;
    wHitPoint: word;
    wWalkSpeed: word;
    wWalkStep: word;
    wWalkWait: word;
    wAttackSpeed: word;
    ItemList: TList;
  end;
  pTMonInfo = ^TMonInfo;




  TMonItem = record
    n00: integer; //0-3                  ����-1/
    n04: integer; //4567                  ��ĸ
    sMonName: string[20]; //8901234567     //��������
    n18: integer; //8             ��������
  end;
  pTMonItem = ^TMonItem;



  TMonItemInfo = record //�����ṹӦ��һ����  TMonItem = TMonItemInfo
    SelPoint: Integer;
    MaxPoint: Integer;
    ItemName: string[20];
    Count: Integer;
  end;
  PTMonItemInfo = ^TMonItemInfo;

  pTItemRule=^TItemRule;
  TItemRule=packed record
    Name              : string[15];
    case byte of
     0:(

    boDisableDeal     : Boolean;     //��ֹ���� 0
    boDisableMake     : Boolean;     //��ֹ���� 1
    boDisableDrop     : Boolean;     //��ֹ���� 2
    boDisableTakeoff  : Boolean;     //��ֹȡ�� 3
    boDisableSave     : Boolean;     //��ֹ��� 4
    boDisableONSell   : Boolean;     //��ֹ��̯ 5
    boDisableUpDate   : Boolean;     //��ֹ���� 6
    boDisableRepair   : Boolean;     //��ֹ��ͨ���� 7
    boDisableRepairL  : Boolean;     //��ֹ�������� 8
    boDisablebqss     : Boolean;      //��ֹ��Ȫʥˮ9
    boDisableTakeon   : Boolean;     //��ֹ���崩�� 10
    boDisableYSTakeOn : Boolean;     //��ֹԪ�񴩴� 11
    boDisableRedName  : Boolean;     //��ֹ�������� 12
    boDisableYs       : Boolean;     //��ֹ����Ԫ����� 13
    boDisablePet      : Boolean;     //��ֹ���������� 14
    boDisableDieOut   : Boolean;     //��ֹ��������     15
    boDisableDieOutOn : Boolean;     //��ֹ���ϱ���     16
    boDisableSell     : Boolean;     //��ֹ����         17
    boDisableREName   : Boolean;     //��ֹ����         18
    boDisableJP       : Boolean;     //��ֹ��Ʒ         19
    boDisableclear    : Boolean;     //��ֹ����         20
    );
    1:(bospcode:array[0..20] of boolean);

  end;
  TQiYuanTree=packed record
    wLooks     : Word;
    sItemName  : string[14];
  end;
  THumMagicInfo = packed record
    wMagIdx: word;
    btLevel: byte;
    btKey: byte;
    nTranPoint: integer;
  //  UserMagic:TMagicInfo;
  end;
  pTHumMagicInfo = ^THumMagicInfo;

  TMinMap = record
    sName: string[17];
    nID: Integer;
  end;
  pTMinMap = ^TMinMap;
  TMapRoute = record
    sSMapNO: string[17];
    nDMapX: Integer;
    nSMapY: Integer;
    sDMapNO: string[17];
    nSMapX: Integer;
    nDMapY: Integer;
  end;
  pTMapRoute = ^TMapRoute;
  TMapInfo = record
    sName: string[17];
    sMapNO: string[17];
    nL: Integer; //0x10
    nServerIndex: Integer; //0x24
    nNEEDONOFFFlag: Integer; //0x28
    boNEEDONOFFFlag: Boolean; //0x2C
    sShowName: string[14]; //0x4C
    sReConnectMap: string[14]; //0x50
    boSAFE: Boolean; //0x51
    boDARK: Boolean; //0x52
    boFIGHT: Boolean; //0x53
    boFIGHT3: Boolean; //0x54
    boDAY: Boolean; //0x55
    boQUIZ: Boolean; //0x56
    boNORECONNECT: Boolean; //0x57
    boNEEDHOLE: Boolean; //0x58
    boNORECALL: Boolean; //0x59
    boNORANDOMMOVE: Boolean; //0x5A
    boNODRUG: Boolean; //0x5B
    boMINE: Boolean; //0x5C
    boNOPOSITIONMOVE: Boolean; //0x5D
  end;
  pTMapInfo = ^TMapInfo;


  TOSObject = record
    btType: byte;
    CellObj: TObject; //pointer;//TObject;
    dwAddTime: dword;
  end;
  pTOSObject = ^TOSObject;

  TUnbindInfo = record
    nUnbindCode: Integer;
    sItemName: string[14];
  end;
  pTUnbindInfo = ^TUnbindInfo;

  TQuestDiaryInfo = record
    QDDinfoList: TList;
  end;
  pTQuestDiaryInfo = ^TQuestDiaryInfo;

  TAdminInfo = record
    nLv: Integer;
    sChrName: string[14];
    sIPaddr: string[15];
  end;
  pTAdminInfo = ^TAdminInfo;

  TAbility = packed record //OK    //Size 40
    Level: word; //0x198  //0x34
 //   bt035         :Byte;

    AC: DWord; //0x19A  //0x36
    MAC: DWord; //0x19C  //0x38
    DC: DWord; //0x19E  //0x3A
    MC: DWord; //0x1A0  //0x3C
    SC: DWord; //0x1A2  //0x4E

    HP: Word; //0x1A4  //0x40
    MP: Word; //0x1A6  //0x42
    MaxHP: Word; //0x1A8  //0x44
    
    MaxMP: Word; //0x1AA  //0x46
    dw1AC         :Dword;  //0x1AC  //0x48
    Exp: Dword; //0x1B0  //0x4C
    MaxExp: Dword; //0x1B4  //0x50
    Weight: Word; //0x1B8   //0x54
    MaxWeight: Word; //0x1BA   //0x56
    WearWeight: word; //Byte;  //0x1BC   //0x58
    MaxWearWeight: word; //Byte;  //0x1BD   //0x59
    HandWeight: word; //Byte;  //0x1BE   //0x5A
    MaxHandWeight: word; //Byte;  //0x1BF   //0x5B
     dwunknow:DWORD;
  end;
  pTAbility = ^TAbility;

  TMYOAbility = packed record
    Level: word; //0x198  //0x34
 //   bt035         :Byte;
    AC: Word; //0x19A  //0x36
    MAC: Word; //0x19C  //0x38
    DC: Word; //0x19E  //0x3A
    MC: Word; //0x1A0  //0x3C
    SC: Word; //0x1A2  //0x4E
    HP: Word; //0x1A4  //0x40
    MP: Word; //0x1A6  //0x42
    MaxHP: Word; //0x1A8  //0x44
    MaxMP: Word; //0x1AA  //0x46
    dw1AC: Dword; //0x1AC  //0x48
    Exp: Dword; //0x1B0  //0x4C
    MaxExp: Dword; //0x1B4  //0x50
    Weight: Word; //0x1B8   //0x54
    MaxWeight: Word; //0x1BA   //0x56
    WearWeight: Byte; //0x1BC   //0x58
    MaxWearWeight: Byte; //0x1BD   //0x59
    HandWeight: Byte; //0x1BE   //0x5A
    MaxHandWeight: Byte; //0x1BF   //0x5B
    lingli: word;
    yuanqi: word;
  //  yslevel:word;
  end;
  TOAbility = packed record
   Level: word; //0x198  //0x34
 //   bt035         :Byte;
    AC: Word; //0x19A  //0x36
    MAC: Word; //0x19C  //0x38
    DC: Word; //0x19E  //0x3A
    MC: Word; //0x1A0  //0x3C
    SC: Word; //0x1A2  //0x4E
    HP: Word; //0x1A4  //0x40
    MP: Word; //0x1A6  //0x42
    MaxHP: Word; //0x1A8  //0x44
    MaxMP: Word; //0x1AA  //0x46
    dw1AC: Dword; //0x1AC  //0x48
    Exp: Dword; //0x1B0  //0x4C
    MaxExp: Dword; //0x1B4  //0x50
    Weight: Word; //0x1B8   //0x54
    MaxWeight: Word; //0x1BA   //0x56
    WearWeight: Byte; //0x1BC   //0x58
    MaxWearWeight: Byte; //0x1BD   //0x59
    HandWeight: Byte; //0x1BE   //0x5A
    MaxHandWeight: Byte; //0x1BF   //0x5B

  end;


  TWAbility = record
    dwExp: LongWord; //0x194  ���ﾭ��ֵ(Dword)
    wHP: Word; //0x1A4
    wMP: Word; //0x1A6
    wMaxHP: Word; //0x1A8
    wMaxMP: Word; //0x1AA
  end;
  TMerchantInfo = record
    sScript: string[14];
    sMapName: string[14];
    nX: Integer;
    nY: Integer;
    sNPCName: string[40];
    nFace: Integer;
    nBody: Integer;
    boCastle: Boolean;
  end;
  pTMerchantInfo = ^TMerchantInfo;

  TSocketBuff = record
    Buffer: PChar; //0x24
    nLen: Integer; //0x28
  end;
  pTSocketBuff = ^TSocketBuff;
  TSendBuff = record
    nLen: Integer;
    Buffer: array[0..DATA_BUFSIZE - 1] of Char;
  end;
  pTSendBuff = ^TSendBuff;

  TUserItem = packed record //24
   wIndex    : Word;   // 2
   MakeIndex : Integer;     //4

    Dura      : Word;         //2
    DuraMax   : Word;         //2
    btValue   :  array[0..19]of byte;     //14
    DarkProp  :  TDarkProperty;	//�¼�{�ڰ�����}
    AttachMagic: TAttachMagicRCD;//�¼�{��ħ����}
  end;


  PTUserItem = ^TUserItem;
  pTPetSellInfo=^TPetSellInfo;
  TPetSellInfo=packed record
   sMasterName    :  string[15];
   nMakeIndex     :  Integer;
   nSellItemCount :  Integer;
   nSellGold      :  Integer;
   nSellYuanBao   :  Integer;
   nSellItem      :  array[0..MAXPETSELLCOUNT-1] of TUseritem;
  end;
  TMonDrop = record
    sItemName: string[20];
    nDropCount: integer;
    nNoDropCount: integer;
    nCountLimit: integer;
  end;
  pTMonDrop = ^TMonDrop;


//  Tcolor=(c_Red,c_Green,c_Blue,c_White);

  TMonSayMsg = record
    State: TMonStatus;
    Color: TMsgColor;
    nRate: integer;
    sSayMsg: string;
  end;
  pTMonSayMsg = ^TMonSayMsg;


  TGateUserInfo = record

    sAccount: string[12];
    sCharName: string[14];
    sIPaddr: string[15];
    nSessionID: integer;
    nGSocketIdx: integer;
    nSocket: integer;
    dwNewUserTick: LongWord;
    nClientVersion: integer;
    boCertification: boolean;

    PlayObject: TObject; //TplayObject;
    FrontEngine: TObject; //TFrontEngine ;
    UserEngine: TObject; //TUserEngine ;

    SessInfo: pTSessInfo;
  end;
  pTGateUserInfo = ^TGateUserInfo;







  TMapItem = record
    Name: string[15];
    Looks: Word;
    AniCount: Byte;
    Reserved: Byte;
    Count: Integer;
    UserItem: TUserItem;
    OfBaseObject: TObject;
    dwCanPickUpTick: LongWord;
    DropBaseObject: TObject;
    DropName:string;
  end;
  PTMapItem = ^TMapItem;


  TVisibleBaseObject = record
    BaseObject: TObject;
    nVisibleFlag: integer;
    MapItem: PTMapItem;
    nX: integer;
    nY: integer;

    sName: string[15];
    wLooks: integer;
  end;
  pTVisibleBaseObject = ^TVisibleBaseObject;

  TVisibleMapItem = record
    nVisibleFlag: integer;
    MapItem: PTMapItem;
    nX: integer;
    nY: integer;

    sName: string[15];
    wLooks: integer;


  end;
  pTVisibleMapItem = ^TVisibleMapItem;

  TSwitchDataInfo = record
    sMap: string[17];
    wX: integer;
    wY: integer;
    Abil: TAbility;
    sChrName: string[14];
    nCode: integer;
    boC70: boolean;
    boBanShout: boolean;
    boHearWhisper: boolean;
    boBanGuildChat: boolean;
    boAdminMode: boolean;
    boObMode: boolean;
    BlockWhisperArr: array[0..4] of string;
    SlaveArr: array[0..5] of TSlaveInfo;
    StatusValue: array[0..8] of word; //     xjs    0..6
    StatusTimeOut: array[0..8] of LongWord; //     xjs     0..6
  end;
  pTSwitchDataInfo = ^TSwitchDataInfo;



 TRecordHeader = packed record // 28
    boDeleted: boolean; //  1
    btCount: byte; // 1
    nSelectID: word; // 2
    dCreateDate: TDateTime; //8
    sAccount:string[16];
     //  UpdateDate:TDateTime;      //19
    sname: string[15]; //28
  end;

  TLoadHuman =packed record
    sAccount: string[16];
    sChrName: string[14];
    sUserAddr: string[15];
    nSessionID: Integer;
    boYS:Boolean;
  end;




  THumanUseItems = array[0..14] of TUserItem;
 
  THumItems = array[0..12] of TUserItem; //hint
  pTHumItems = ^THumItems;
  TBagItems = array[0..65] of TUserItem; //45
  pTBagItems = ^TBagItems;

  TStorageItems = array[0..39] of TUserItem; //38 5    43
  pTStorageItems = ^TStorageItems;

  TmonStorageItems = array[0..19] of TUserItem; //38 5    43
  pTmonStorageItems = ^TStorageItems;


  THumMagic = array[0..39] of THmagic; //TUserMagic;  //0..19

  pTHumMagic = ^THumMagic;








    TPneuma_2=packed record
      btsex_1 : Byte; //1
      btJob_1 : Byte; //1
      Abil: TAbility;
      Magic:THumMagic;
  end;

  THumData = packed record
    sChrName: string[14]; //0
    sCurMap: string[16]; //0x0f
    wCurX: word; //0x20
    wCurY: word; //0x22
    btDir: byte; //0x24
    btHair: Byte; //0x25
    btsex: Byte; //0x26
    btJob: Byte; //0x27
    Abil: TAbility; // 0x28 ռ 58�ֽ�
    sAccount: string[16]; //0x62
    sHomeMap: string[15]; //0x73
    wHomeX: word; // 0x83
    wHomeY: word; // 0x85
    sDearName: string[14]; //0x87
    boMaster: boolean;//0x96
    sMasterName: string[44]; //0x97
    btCreditPoint: word; //0xc4 ����ֵ
    sStoragePwd: string[8]; //0xc6
    // ///////////////////////////////////////////////
     btReLevel: integer; //0xcf
     btmemo:array[0..10] of byte;
     nBonusPoint: integer; //1
     btMarryCount: word; //4
     wStatusTimeArr: Tstatustime; //96; 48     //��������״̬>12
     btAllowGroup: byte;  //0x120
     btAttatckMode: byte;
     btIncHealth: byte;
     btIncSpell: byte;
     btIncHealing: byte;
     btFightZoneDieCount: byte;
     boLockLogon: boolean;

    nHungerStatus: integer;
    boAllowGuildReCall: boolean;
    wGroupRcallTime: word;
    dBodyLuck: Double; //8
    boAllowGroupReCall: boolean; //26              74
    QuestUnitOpen: TQuestUnit; //100
    QuestUnit: TQuestUnit; //0x11C   //100
    QuestFlag: TQuestFlag;
    m_bMaxBagitem: byte; // ����������
    m_sSytleName: string[80]; //������Ի�ǩ��
    SpecialItemPoint: integer; //��Ʒ����ֵ
    nyssex: byte;
    nysjob: byte;
    wyslevel: word;
    m_nJpPoint: Integer;
    m_YSPoint: Integer;
    M_YSfenghao: integer;
    m_nGameCode : Integer;
    btLXBHCount:Byte;
    btLXBHItemCount:Byte;       //��Ϭ����

    nLXBHTIme : Integer;
    nyssex_1: byte;
    nysjob_1: byte;
    wyslevel_1: word;
    btHasYS2  : Byte;
    sDieMap: string[17]; // 16
    wDieX: word; // 2
    wDieY: word; //  2
    BonusAbil: TNakedAbility; //20   //
/////////////////////////////
    nGold: integer;    //0x26a
    nGameGold: integer; //0x26e
    nGamePoint: integer; //0x272
    nPayMentPoint: integer; //0x276��ֵ��
    wPKPoint: WOrd; //0x27a
    wContribution: word; //0x27c
    unknown1:array[0..7] of byte;//0x27e
    wATTACHEPOINT:Word;
    wGEMCOUNT:array[0..2]of Word;

    unknown2:array[0..27] of byte;//0x27e
    boYS:Boolean;//0x2aa  �Ƿ�ΪԪ��
    sYsname: string[14];//0x2ab
    btYS:Byte;//0 û��Ԫ�� 1 �� 2 Ů
    unkonown2:array[0..14] of Byte; //0x2ba
    btAdditionalAbil:array[0..14] of Byte; //ԪӤ����  0x2ca
    unkonown3:array[0..3] of Byte;//0x2d9
     Pneuma_2 :TPneuma_2;//0x2df  ��298�ֽ�
     btMemo1:array[0..16] of Byte;    //0x409
     Hum_HunZhuItem: TUserItem; //0x46c;  86�ֽ� ����
     wMemo12:Word;
     Hum_ShieldItem: TUserItem; //0x4c2;  86�ֽ�
     btmemo111:array[0..161]of Byte;//0x518
     Magic: THumMagic; //0x5ba
     btmemo3:array[0..38]of Byte;//0x6fa
     HumItems: THumItems; //0x721
     BagItems: TBagItems; //
     StorageItems: TStorageItems;     //0x21ab
     monStorageItems: TmonStorageItems; //2f1b



  end;

  pTHumData = ^THumData;

  THumInfo = packed record //
    Header: TRecordHeader; //45
     sAccount: string[16]; // 11s
     boSelected: boolean;
     boDeleted: boolean;
     UpdateDate: TDateTime;
      btCount: byte; //��������
     sChrName: string[14]; //14

  {  boDeleted: boolean; //   1
    boSelected: boolean; //               1
    btCount: byte; //��������       1
    UpdateDate: TDateTime; //20      //         8
    dModDate: TDateTime; //          8
    btMemo:array[0..67] of byte;}
  end;


  THumDataInfo = packed record //   3164
    Header: TRecordHeader; //THumInfo;
    data: THumData;
//  boSelected   :boolean;
  end;

  TSaveRcd = record
    sAccount: string[14];
    sChrName: string[14];
    nSessionID: integer;
    PlayObject: TObject; //tPlayObject;
    HumanRcd: THumDataInfo;
    nCode: integer;
    nReTryCount: integer;
    boNewYs: boolean;
{    sHair:string[4];
   sJob:string[4];
   sSex:string[4];
   sYsnameMaster:String[14];  }
  end;
  pTSaveRcd = ^TSaveRcd;




  TLoadUser = record
    nSessionID: integer;
    nSocket: integer;
    nGateIdx: integer;
    nGSocketIdx: integer;
    sAccount: string[12];
    sIPaddr: string[15];
    nPayMent: integer;
    nPayMode: integer;
    dwNewUserTick: LongWord;
    nSoftVersionDate: integer;
  end;

  TUserOpenInfo = record
    sChrName: string[14];
    LoadUser: TLoadDBInfo;
    HumanRcd: THumDataInfo;
  end;
  pTUserOpenInfo = ^TUserOpenInfo;






  TSendMessage = record
    wIdent: word;



    wParam: word;
    nParam1: integer;
    nParam2: integer;
    nParam3: integer;
    dwDeliveryTime: LongWord;
    BaseObject: TObject;
    boLateDelivery: boolean;
    Buff: pchar;
  end;
  pTSendMessage = ^TSendMessage;

  TObjectFeature = record
    btGender: Byte;
    btWear: Byte;
    btHair: Byte;
    btWeapon: Byte;
  end;
  pTObjectFeature = ^TObjectFeature;

  TGateObj = record
    DEnvir: TObject; //TEnvirnoment;
    nDMapx: integer;
    nDMapY: integer;
    boFlag: boolean;
  end;
  pTGateObj = ^TGateObj;



  TStatusInfo = record
    nStatus: Integer; //0x60
    dwStatusTime: LongWord; //0x1E8
    sm218: SmallInt; //0x218
    dwTime220: LongWord; //0x220
  end;
  TMsgHeader = packed record //$14 ok
    dwCode: LongWord; //4
    nSocket: integer; //4

    wGateIndex: Word; //2
    wIdent: Word; //2
    nUserListIndex: integer; //0x0C      4

    nLength: integer; //0x10      4


  end;
  pTMsgHeader = ^TMsgHeader;



  TUserEntry = packed record
    sAccount: string[16];
    SPassword: string[10];
    SUserName: string[20];
    SSSNo: string[14]; //hint 14
    SPhone: string[14];
    SQuiz: string[20];
    SAnswer: string[12]; //hint  12
    SEMail: string[40];
  end;
  TUserEntryAdd = packed record
    SQuiz2: string[20];
    SAnswer2: string[12]; //hint 12
    SBirthDay: string[10];
    SMobilePhone: string[13];
    sMemo: string[20];
    sMemo2: string[20];
  end;





  tnameheander = packed record
    sName: string[14];
    nSelectID: integer;
    UpdateDate: tdatetime;
  end;

  TAcDBInfo = packed record //
    boDeleted: boolean; //
    btCount: byte;
    nSelectID: word;
    CreateDate: TDateTime;
    UpdateDate: TDateTime; //20


    sAccount: string[16];

  end;

  TAccountDBRecord = packed record
    Header: TAcDBInfo; //  32
    UserEntry: TUserEntry;
    UserEntryAdd: TUserEntryAdd;
    nErrorCount: integer;
    dwActionTick: dword; //   32+14   -8

  end;



  TUserInfo = record
    bo00: Boolean; //0x00
    bo01: Boolean; //0x01 ?
    bo02: Boolean; //0x02 ?
    bo03: Boolean; //0x03 ?
    n04: Integer; //0x0A ?
    n08: integer; //0x0B ?
    bo0C: Boolean; //0x0C ?
    bo0D: Boolean; //0x0D
    bo0E: Boolean; //0x0E ?
    bo0F: Boolean; //0x0F ?
    n10: Integer; //0x10 ?
    n14: Integer; //0x14 ?
    n18: Integer; //0x18 ?
    sStr: string[20]; //0x1C
    nSocket: integer; //0x34
    nGateIndex: Integer; //0x38
    n3C: integer; //0x3C
    n40: integer; //0x40 ?
    n44: integer; //0x44
    List48: TList; //0x48
    Cert: TObject; //0x4C
    dwTime50: LongWord; //0x50
    bo54: Boolean; //0x54
  end;
  pTUserInfo = ^TUserInfo;

  TGlobaSessionInfo = record
    sAccount: string[12];
    sIPaddr: string[15];
    nSessionID: Integer;
    n24: Integer;
    bo28: Boolean;
    dwAddTick: LongWord;
    dAddDate: TDateTime;
    boLoadRcd: BOOLEAN;
    boStartPlay: BOOLEAN;
  end;
  pTGlobaSessionInfo = ^TGlobaSessionInfo;


  TSELLITEMFLAG = packed record
 // n1:integer;
//  n2:integer;
    w1: word;
    sellend: byte; //����=255 ��ʼ=0
    bflag: byte; //������=1 û��=0
    flagcolor: integer;

    w3: word;
    SellName: array[0..51] of char;
  end;

  TMYSELLITEMFLAG = packed record
    w1: word;
    sellend: byte; //����=255 ��ʼ=0
    bflag: byte; //������=1 û��=0
    flagcolor: integer;
  end;

  TSellitem = packed record
    nID: integer; // ��Ʒid
    nGod: integer; //  �������
    wTpye: word; //   �Ƿ���Ԫ��    1 Ԫ�� 0 ���
  end;
  pTsellitem = ^TSellitem;

  TSendSell = packed record //���ܵ��İ�̯��������
    SellName: array[0..51] of char;
    Sellitems: array[0..9] of TSellitem;
  end;

  TonSellItemdata = packed record
    n1: integer;
    n2: integer;
    w3: word; //��Ʒ����
    name: array[0..51] of char;
    Sellitemarr: array[0..9] of TClientItem; //    //NeedIdentify=1 ��ʾ��Ԫ�����ף�NeedIdentify=0 ��ʾ�ý��
  end;
  tMAGICFIRE = record
    Targe: integer;
    color: integer;
    count: Byte;
  end;
  Tshoplist = record
    name: string[20];
    count: integer;
    itemlist: string[100];
  end;
  Tshopbigtype = record
    count: integer;
    shoplist: array of Tshoplist;
  end;
  Tshop = record
    type_top: TshopBIGTYPE;
    type_10: TshopBIGTYPE;
    type_20: TshopBIGTYPE;
    type_30: TshopBIGTYPE;
    type_40: TshopBIGTYPE;
    type_50: TshopBIGTYPE;
  end;


  TSM47dat = packed record
    nFeature: Integer;
    nStatus: Integer;
    nplayobject: integer;
    n4: integer; // �ƻ����� $60000  �ƶ�ն   $70000
              // ����� $30000  �һ� $10000  ��Ѫ���� $20000
  end;

  TSM5960dat = packed record
    w1: word;
    n4: integer;
  end;
  tmyslave = packed record
    btlevel: byte;
    charname: array[0..13] of char;
    hp: word;
    maxhp: word;
    dc: word; // 6-25
    ac: byte; // ����
    mac: byte; //    ħ��
    char2f: byte;
  end;

  Tuselingfurec = packed record
    monid: integer;
    nx: word;
    ny: word;
    ntype: word;
  end;



  Tnmpfileheader = record
    handlength: dword; //0..3
    flag: dword; //4..7

    x: dword; //8..11
    y: dword; //12.15
    unknown4: dword; // 16..19
    unknown5: dword; //  20..23
    unknown6: dword; //24..27
    unknown7: dword; //28..31
  end;
  Tnmpcellflag1 = packed record //12 b
    n1: dword;
    n2: dword;
    n3: dword;
  end;
  pTnmpcellflag1 = ^Tnmpcellflag1;

  Tkeystring = record
    gameip: string[50];
    rungate_run: string[200]; // TRSkt.R
    GM_OPEN: string[50]; //     = 1;                        //���� 1
    GM_CLOSE: string[50]; //   = 2;                                  //���� 2
    GM_DATA: string[50]; //  = 5;
    SM_LOGON: string[50]; //50
    SM_FEATURECHANGED: string[50]; //41
    SM_BAGITEMS: string[100]; //201
    SM_SUBABILITY: string[100]; //   = 752;
    SM_SENDMYMAGIC: string[100]; //     = 211;
    SM_GAMEGOLDNAME: string[200]; //     = 59001; //? 10015                //���� 59001
    SM_MAGADDABILTY: string[200]; //     = 21292 ;            //���� 21292
  end;

  Ttopnpc = record
    sname: string;
    sguildname: string;
    slevel: string;
    sdate: string;
    npcappr: string;
    job: string;
  end;
  Ttimergoto = record
    boActive: boolean;
    sgotolabel: string[20];
    sCharname: string[15];
    dwEndtick: dword;
  end;
  pTtimergoto = ^Ttimergoto;

  Tbagitempos = packed record
    itemmake: integer;
    pos: word; // 0..65   60..65  Ϊ ����6����
  end;
  pTbagitempos = ^Tbagitempos;
  TYSskillEffect = record
    monId: integer;
    skilltype: integer;
    ysId: integer;
  end;

  TYsBagItem = packed record
    YsId: integer;
    ItemMake: integer;
    Flag: byte;
    send: byte;
  end;
  pTYsBagItem = ^TYsBagItem;

  TPaiHangBang = packed record
    Index: word;
    CharName: array[0..13] of Char;
    Level: byte;
    Job: byte;
    Sex: byte;
    GuildName: array[0..29] of Char; //13
    PreSent: Byte;
    YsJob: byte;
    YsLevel: Byte;
    wMemo:Word;
  end;


  Thanghuipaihang = packed record
    ID: WORD;
    GuildName: array[0..13] of char;
    UNKnow1: array[0..15] of char;
    topCharNum: word;
    YscharNUM: word;
    GuildCharCount: word;
    UNKnow2: word;
    GuildExp: Dword;
  end;

  Tbaozipaihang = packed record
    ID: WORD;
    baoziName: array[0..13] of char;
    baozilevel: word;
    baoziexp: word;
    baozifenghao: array[0..13] of char;
    baoziMaster: array[0..13] of char;
    MasterJob: word;
  end;

  TYSpaihang = packed record
    ID: WORD;
    YSCharName: array[0..13] of char;
    YSlevel: byte;
    YSjob: byte;
    YSsex: byte;
    YSjipin: byte;
    UNKnow1: byte;
    YSMasterCharName: array[0..13] of char;
    MasterLevel: byte;
    MasterGuildName: array[0..13] of char;
   //    UNKnow2:array[0..15]of char;
  end;
  TMasterpaihang = packed record
    ID: WORD;
    MasterCharName: array[0..13] of char;
    TudiCount: word;
    level: byte;
    job: byte;
    Sex: byte;
    MasterGuildName: array[0..13] of char;
    UNKnow1: array[0..4] of char;
  end;

  TSavePaiHang = packed record
    CharName: array[0..13] of Char;
    Level: byte;
    Job: byte;
    Sex: byte;
    GuildName: array[0..13] of Char;
    PreSent: Byte;
    YsJob: byte;
    YsLevel: Byte;
  end;
  pSavePaiHang = ^TSavePaiHang;


  TNMPMap = array[0..1000 * 1000 - 1] of byte;
  pNMPTMap = ^TNMPMap;

  T15keyString = packed record
    varSM_FEATURECHANGED: Integer;

    VARSM_SUBABILITY: Integer;

    VARSM_MAGADDABILTY: Integer;

    VARSM_BAGITEMS: Integer;

    VARSM_GAMEGOLDNAME: Integer;

    VARSM_LOGON: Integer;
    VARSM_SENDMYMAGIC: Integer;
    RegTime: TDateTime;
  end;


var
  arrip: array[0..19] of char;
  keystring: Tkeystring;
  VARSM_LOGON: integer; //50
  VARSM_FEATURECHANGED: integer; //41
  VARSM_BAGITEMS: integer; //201
  VARSM_SUBABILITY: integer; //   = 752;
  VARSM_SENDMYMAGIC: integer; //     = 211;
  VARSM_GAMEGOLDNAME: integer; //     = 59001; //? 10015                //���� 59001
  VARSM_MAGADDABILTY: integer; //
  shopfile, topfile: TIniFile;
  mdbyzstring: string;
  topnpcarr: array[1..8] of Ttopnpc;
 //   RegUser    :string;
  keyStringType: T15keyString;
  nSysTime: TDateTime;
  nSysTimeTick:Cardinal;
// var
      //      CSTGLIST       :TRTLCriticalSection;
      //      CSTGsLIST       :TRTLCriticalSection;
implementation

constructor TGlist.Create;
begin
  inherited Create;
  InitializeCriticalSection(CriticalSection);
end;

destructor TGlist.Destroy;
begin
  try
    inherited Destroy;
  finally
    DeleteCriticalSection(CriticalSection);
  end;
end;

procedure TGlist.lock;
begin
   //   EnterCriticalSection(CSTGLIST);
  EnterCriticalSection(CriticalSection);
end;

procedure TGlist.unlock;
begin
  LeaveCriticalSection(CriticalSection);
    //    LeaveCriticalSection(CSTGLIST);
end;


constructor TGStringList.Create;
begin
  inherited Create;
  InitializeCriticalSection(CriticalSection);
end;

destructor TGStringList.Destroy;
begin
  try
    inherited Destroy;
  finally
    DeleteCriticalSection(CriticalSection);
  end;
end;


procedure TGStringList.lock;
begin
  EnterCriticalSection(CriticalSection); //  EnterCriticalSection(CSTGsLIST);
end;

procedure TGStringList.unlock;
begin
  LeaveCriticalSection(CriticalSection); //   LeaveCriticalSection(CSTGsLIST);
end;

initialization
  begin


  end;
finalization
  begin
  end;

end.
