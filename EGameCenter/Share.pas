unit Share;

interface
uses
  Windows,Classes,SysUtils,JSocket,RSA;
const
  MAXSESSION = 2000;

const
  VERDEMO      = 0;
  VERFREE      = 1;
  VERSTD       = 2;
  VEROEM       = 3;
  VERPRO       = 4;
  VERENT       = 5;
  SoftVersion  = VERSTD; //����汾����
{$IF SoftVersion = VERENT}
  DLLVersion = 98;
{$ELSE}
  DLLVersion = 15;
{$IFEND}
  DEBUG      = 0;
  SELFCRC   :LongWord = 2190575127;//3937893187
type
  TCheckStatus = (c_Idle,c_Connect,c_Checking,c_CheckError,c_CheckFail,c_CheckOK);
  TCheckStep = (c_None,c_SendClinetKey,c_SendLicense,c_SendLicense2,c_CheckOver);
  TSessionStatus = (s_NoUse,s_Used,s_GetLic,s_SendLic,s_Finished);
  TUserLicense = record
    Userkey   :String[12];
    UserIP    :String[15];
    ServerIP  :String[15];
    ServerPort:Integer;
  end;
  TXORItem   = packed  record
    SoftType    : ShortInt;//1    1=M2Server 2=RunGate 3=DBServer
    MainVersion : Single;  //4    ������汾��
    DLLVersion  : Single;  //4    DLL�汾��
    IniRegIP    : Integer; //4    ��INI����д��Reg IP
    Param1      : Integer; //4    �����Ժ���
    Param2      : String[15];     //�����Ժ���
  end;
  TXORRecord = packed record
    XORKey      : Integer;       //��Ҫ�ֶΣ������ж��Ƿ������ǵ���֤������
    XORItemLen  : Integer;
    XORItem     : String[33];    //���Ⱥ� TXORItemһ����
  end;
  TRSARecord = packed record
    RSAKey      : Int64;
    RSAItemLen  : Integer;
    RSAItem     : TInt64Item;   //����TXORRecord RSA���ܺ�Ľ��
  end;
  pRSARecord = ^TRSARecord;

  TUserLicenseEx = packed record
    UserLicese  : TUserLicense; //����RSA����ǰ�İ汾
    RSARecord   : TRSARecord;   //RSA����
  end;

  TIPAddr = record
    A:Byte;
    B:Byte;
    C:Byte;
    D:Byte;
    Port:Integer;
  end;
  TSession = record
    Socket      :TCustomWinSocket;
    sReviceMsg  :String;
    nRemoteAddr :Integer;
    dwStartTick :LongWord;
    CheckStep   :TCheckStep;
    UserLicense :TUserLicense;
    CodeBuff    :PChar;
    nCodeLen    :Integer;
    nLicDays    :Integer; //��Ȩʣ������
    nUserCount  :Integer; //�û���
    Status      :TSessionStatus;//�����Ȩ
    dwSendLicTick:LongWord;
    dwClientTick:LongWord;
    dwServerTick:LongWord;
  end;
  pTSession = ^TSession;

  function MakeIPToStr(IPAddr:TIPAddr):String;
  function MakeIPToInt(sIPaddr:String):Integer;
var
  nLocalXORKey:Integer;   //����XOR Key
  nRemoteXORKey:Integer;
implementation

uses HUtil32;
function MakeIPToStr(IPAddr:TIPAddr):String;
begin
  Result:=IntToStr(IPAddr.A) + '.' + IntToStr(IPAddr.B) + '.' + IntToStr(IPAddr.C) + '.' + IntToStr(IPAddr.D);
end;
function MakeIPToInt(sIPaddr:String):Integer;
var
  sA,sB,sC,sD:String;
  A,B,C,D:Byte;
begin
  Result:= -1;
  sIPaddr:=Trim(GetValidStr3(sIPaddr, sA, ['.']));
  sIPaddr:=Trim(GetValidStr3(sIPaddr, sB, ['.']));
  sD:=Trim(GetValidStr3(sIPaddr, sC, ['.']));
  if (sA <> '') and (sB <> '') and (sC <> '') and (sD <> '') then begin
    A:=Str_ToInt(sA,0);
    B:=Str_ToInt(sB,0);
    C:=Str_ToInt(sC,0);
    D:=Str_ToInt(sD,0);
    Result:=MakeLong(MakeWord(A,B),MakeWord(C,D));
  end;
end;

end.
