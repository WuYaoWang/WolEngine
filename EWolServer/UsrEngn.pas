unit UsrEngn;

interface
uses
  Windows, Classes, SysUtils, StrUtils, Forms, ObjBase, ObjNpc, Envir, Grobal2, Magic;
type

  TUserEngine = class
    m_LoadPlaySection: TRTLCriticalSection;
    m_LoadPlayList: TStringList;                            //��DB��ȡ��������
    m_PlayObjectList: TStringList;                          //0x8
    m_StringList_0C: TStringList;
    m_PlayObjectFreeList: TList;                            //0x10
    m_ChangeHumanDBGoldList: TList;                         //0x14
    dwShowOnlineTick: LongWord;                             //0x18
    dwSendOnlineHumTime: LongWord;                          //0x1C
    dwProcessMapDoorTick: LongWord;                         //0x20
    dwProcessMissionsTime: LongWord;                        //0x24
    dwRegenMonstersTick: LongWord;                          //0x28
    CalceTime: LongWord;                                    //0x2C
    m_dwProcessLoadPlayTick: LongWord;                      //0x30
    dwTime_34: LongWord;                                    //0x34
    m_nCurrMonGen: Integer;                                 //0x38
    m_nMonGenListPosition: Integer;                         //0x3C
    m_nMonGenCertListPosition: Integer;                     //0x40
    m_nProcHumIDx: Integer; //0x44 �������￪ʼ������ÿ�δ������������ƣ�
    nProcessHumanLoopTime: Integer;
    nMerchantPosition: Integer;                             //0x4C
    nNpcPosition: Integer;                                  //0x50
    StdItemList: TList;                                     //List_54
    StdItemofAnnicount: array of Integer;
    MonsterList: TList;                                     //List_58
    m_MonGenList: TList;                                    //List_5C
    m_MonFreeList: TList;
    m_MagicList: TList;                                     //List_60
    m_TimerList: Tlist;
    m_AdminList: TGList;                                    //List_64
    m_MerchantList: TGList;                                 //List_68
    QuestNPCList: TList;                                    //0x6C
    List_70: TList;
    m_ChangeServerList: TList;
    m_MagicEventList: TList;                                //0x78
    nMonsterCount: Integer;                                 //��������
    nMonsterProcessPostion: Integer; //0x80�����������λ�ã����ڼ����������
    n84: Integer;
    nMonsterProcessCount: Integer; //0x88���������������ͳ�ƴ���������
    boItemEvent: Boolean;                                   //ItemEvent
    n90: Integer;
    dwProcessMonstersTick: LongWord;
    dwProcessMerchantTimeMin: Integer;
    dwProcessMerchantTimeMax: Integer;
    dwProcessNpcTimeMin: LongWord;
    dwProcessNpcTimeMax: LongWord;
    m_NewHumanList: TList;
    m_ListOfGateIdx: TList;
    m_ListOfSocket: TList;
    OldMagicList: TList;
    m_PetSellList: TList;
  private
    procedure ProcessMerchants();
    procedure ProcessNpcs();
    procedure ProcessMissions();
    procedure ProcessTimer();
    procedure ProcessEvents();
    procedure ProcessMapDoor();
    procedure NPCinitialize;
    procedure MerchantInitialize;
    function MonGetRandomItems(mon: TBaseObject): integer;
    function RegenMonsters(MonGen: pTMonGenInfo; nCount: integer): Boolean;
    procedure WriteShiftUserData;
    function GetGenMonCount(MonGen: pTMonGenInfo): Integer;
    function makenewplay(s_name: string; human: Tplayobject): TBaseObject;

    procedure GenShiftUserData();
    procedure KickOnlineUser(sChrName: string);

    function SendSwitchData(PlayObject: TPlayObject; nServerIndex: Integer): Boolean;
    procedure SendChangeServer(PlayObject: TPlayObject; nServerIndex: Integer);
    //   procedure SaveHumanRcd(PlayObject:TPlayObject);
    procedure AddToHumanFreeList(PlayObject: TPlayObject);

    procedure GetHumData(PlayObject: TPlayObject; var HumanRcd: THumDataInfo);
    function GetHomeInfo(var nX: Integer; var nY: Integer): string;
    function GetRandHomeX(PlayObject: TPlayObject): Integer;
    function GetRandHomeY(PlayObject: TPlayObject): Integer;
    function GetSwitchData(sChrName: string; nCode: Integer): pTSwitchDataInfo;
    procedure LoadSwitchData(SwitchData: pTSwitchDataInfo; var PlayObject: TPlayObject);
    procedure DelSwitchData(SwitchData: pTSwitchDataInfo);
    procedure MonInitialize(BaseObject: TBaseObject; sMonName: string);
    function MapRageHuman(sMapName: string; nMapX, nMapY, nRage: Integer): Boolean;
    function GetOnlineHumCount(): Integer;
    function GetUserCount(): Integer;
    function GetLoadPlayCount(): Integer;

  public
    constructor Create();
    destructor Destroy; override;
    procedure Initialize();
    procedure ClearItemList(); virtual;
    procedure SwitchMagicList();
    //    function makenewplay(s_name :string;human:Tplayobject):TBaseObject;
    procedure CopyHumData(var PlayObject: TBASEOBJECT; HumData: TPlayObject);
    procedure SaveHumanRcd(PlayObject: TPlayObject);
    procedure NewHumanYS(PlayObject: TPlayObject; sAccount, sChrName: string; bHair,
      bJob, bSex: byte; sYsnameMaster: string; nSessionID: Integer);
    function GetPlayObjectExOfAutoGetExp(sAccount: string): TPlayObject;
    procedure Run();
    procedure PrcocessData();
    procedure Execute;
    procedure ProcessHumans();
    procedure ProcessMonsters();

    function RegenMonsterByName(sMap: string; nX, nY: Integer; sMonName: string):
      TBaseObject;
    function RegenMonsterysByName(sMonName: string; human: Tplayobject): TBaseObject;
    function AddBaseObject(sMapName: string; nX, nY: Integer; nMonRace: Integer;
      sMonName: string): TBaseObject;

    function GetItemAnicount(nItemIdx: Integer): Integer; overload;
    function GetItemAnicount(sItemName: string): Integer; overload;
    function GetStdItem(nItemIdx: Integer): PTStdItem; overload;
    function GetStdItem(sItemName: string): PTStdItem; overload;
    function GetStdItem(nStdMode, nshape: Integer): PTStdItem; overload;
    function GetStdItemWeight(nItemIdx: Integer): Integer;

    function GetStdItemName(nItemIdx: Integer; boFilter: Boolean = True): string;
    function GetStdItemIdx(sItemName: string): Integer;
    function FindOtherServerUser(sName: string; var nServerIndex): Boolean;
    procedure CryCry(wIdent: Word; pMap: TEnvirnoment; nX, nY, nWide: Integer; btFColor,
      btBColor: Byte; sMsg: string);
    procedure ProcessUserMessage(PlayObject: TPlayObject; DefMsg: pTDefaultMessage; Buff:
      PChar);
    procedure SendServerGroupMsg(nCode, nServerIdx: Integer; sMsg: string);
    function GetMonRace(sMonName: string): Integer;
    function GetMonNameByRace(btRace: Integer): string;
    function GetMonRaceImg(sMonName: string): Integer;
    function GetMonAppr(sMonName: string): Integer;
    function GetPlayObject(sName: string): TPlayObject;
    function GetPlayObjectEx(sName: string): TPlayObject;
    procedure KickPlayObjectEx(sName: string);
    procedure endofflineUser(sAccount, sCharName: string; var boys: boolean);
    function FindMon(Mon: TObject): TBaseObject;
    function FindMerchant(Merchant: TObject): TMerchant; overload;
    function FindMerchant(x, y: Integer; sMapName: string): TMerchant; overload;
    function FindMerchant(nFlag: Integer): TMerchant; overload;
    function FindNPC(GuildOfficial: TObject): TGuildOfficial;
    function CopyToUserItemFromName(sItemName: string; Item: pTUserItem): Boolean;
    function GetMapOfRangeHumanCount(Envir: TEnvirnoment; nX, nY, nRange: integer):
      Integer;
    function GetHumPermission(sUserName: string; var sIPaddr: string; var btPermission:
      Byte): Boolean;
    procedure AddUserOpenInfo(UserOpenInfo: pTUserOpenInfo);
    procedure RandomUpgradeItem(Item: PTUserItem);
    procedure GetUnknowItemValue(Item: PTUserItem);
    function OpenDoor(Envir: TEnvirnoment; nX, nY: Integer): Boolean;
    function CloseDoor(Envir: TEnvirnoment; Door: pTDoorInfo): Boolean;
    procedure SendDoorStatus(Envir: TEnvirnoment; nX, nY: Integer; wIdent, wX: Word;
      nDoorX, nDoorY, nA: Integer; sStr: string);
    function FindMagic(sMagicName: string): pTMagic; overload;
    function FindMagic(nMagIdx: Integer): pTMagic; overload;
    procedure AddMerchant(Merchant: TMerchant);
    function GetMerchantList(Envir: TEnvirnoment; nX, nY, nRange: Integer; TmpList:
      TList): Integer;
    function GetNpcList(Envir: TEnvirnoment; nX, nY, nRange: Integer; TmpList: TList):
      Integer;
    function GetMerchantName(NpcIdx: Integer): string;

    procedure ReloadMerchantList();
    procedure ReloadNpcList();
    procedure HumanExpire(sAccount: string);
    function GetMapMonster(Envir: TEnvirnoment; List: TList; nRace: Integer = 0):
      Integer;
    function GetMapMonsterx(Envir: TEnvirnoment; List: TList): Integer;

    function GetAllMonstercount(): Integer;

    function GetMapRangeMonster(Envir: TEnvirnoment; nX, nY, nRange: Integer; List:
      TList): Integer;
    function GetMapHuman(sMapName: string): Integer;
    function GetMapRageHuman(Envir: TEnvirnoment; nRageX, nRageY, nRage: Integer; List:
      TList): Integer;
    procedure SendBroadCastMsg(sMsg: string; MsgType: TMsgType; color: TMsgColor =
      c_Red);
    procedure SendBroadCastMsgExt(sMsg: string; MsgType: TMsgType);
    procedure sub_4AE514(GoldChangeInfo: pTGoldChangeInfo);
    procedure ClearMonSayMsg();
    procedure SendQuestMsg(sQuestName: string);
    procedure DemoRun();
    procedure ClearMerchantData();
    property MonsterCount: Integer read nMonsterCount;
    property OnlinePlayObject: Integer read GetOnlineHumCount;
    property PlayObjectCount: Integer read GetUserCount;
    property LoadPlayCount: Integer read GetLoadPlayCount;
  end;

var
  g_dwEngineTick                                       : LongWord;
  g_dwEngineRunTime                                    : LongWord;

implementation

uses IdSrvClient, Guild, ObjMon, M2Share, EDcode, ObjGuard, ObjAxeMon,
  ObjMon2, Objys, Objmonty, Event, InterMsgClient, InterServerMsg, ObjRobot, HUtil32,
    svMain,
  Castle;
var
  nEngRemoteRun                                        : Integer = -1;
  { TUserEngine }

constructor TUserEngine.Create();
begin
  InitializeCriticalSection(m_LoadPlaySection);
  m_LoadPlayList := TStringList.Create;
  m_PlayObjectList := TStringList.Create;
  m_StringList_0C := TStringList.Create;
  m_PlayObjectFreeList := TList.Create;
  m_ChangeHumanDBGoldList := TList.Create;
  dwShowOnlineTick := GetTickCount;
  dwSendOnlineHumTime := GetTickCount;
  dwProcessMapDoorTick := GetTickCount;
  dwProcessMissionsTime := GetTickCount;
  dwProcessMonstersTick := GetTickCount;
  dwRegenMonstersTick := GetTickCount;
  m_dwProcessLoadPlayTick := GetTickCount;
  dwTime_34 := GetTickCount;
  m_nCurrMonGen := 0;
  m_nMonGenListPosition := 0;
  m_nMonGenCertListPosition := 0;
  m_nProcHumIDx := 0;
  nProcessHumanLoopTime := 0;
  nMerchantPosition := 0;
  nNpcPosition := 0;
  StdItemList := TList.Create;                              //List_54
  MonsterList := TList.Create;
  m_MonGenList := TList.Create;
  m_MonFreeList := TList.Create;
  m_MagicList := TList.Create;
  m_AdminList := TGList.Create;
  m_MerchantList := TGList.Create;
  QuestNPCList := TList.Create;
  m_TimerList := TList.Create;                              //hint
  m_PetSellList := TList.Create;
  List_70 := TList.Create;
  m_ChangeServerList := TList.Create;
  m_MagicEventList := TList.Create;
  boItemEvent := False;
  n90 := 1800000;
  dwProcessMerchantTimeMin := 0;
  dwProcessMerchantTimeMax := 0;
  dwProcessNpcTimeMin := 0;
  dwProcessNpcTimeMax := 0;
  m_NewHumanList := TList.Create;
  m_ListOfGateIdx := TList.Create;
  m_ListOfSocket := TList.Create;
  OldMagicList := TList.Create;
end;

destructor TUserEngine.Destroy;
var
  I                                                    : Integer;
  II                                                   : Integer;
  MonInfo                                              : pTMonInfo;
  MonGenInfo                                           : pTMonGenInfo;
  MagicEvent                                           : pTMagicEvent;
  tmpList                                              : TList;
begin
  for I := 0 to m_LoadPlayList.Count - 1 do
  begin
    Dispose(pTUserOpenInfo(m_LoadPlayList.Objects[I]));
  end;
  m_LoadPlayList.Free;
  for I := 0 to m_PlayObjectList.Count - 1 do
  begin
    TPlayObject(m_PlayObjectList.Objects[I]).Free;
  end;
  m_PlayObjectList.Free;
  m_StringList_0C.Free;

  for I := 0 to m_PlayObjectFreeList.Count - 1 do
  begin
    TPlayObject(m_PlayObjectFreeList.Items[I]).Free;
  end;
  m_PlayObjectFreeList.Free;

  for I := 0 to m_ChangeHumanDBGoldList.Count - 1 do
  begin
    Dispose(pTGoldChangeInfo(m_ChangeHumanDBGoldList.Items[I]));
  end;
  m_ChangeHumanDBGoldList.Free;

  for I := 0 to StdItemList.Count - 1 do
  begin
    Dispose(pTStdItem(StdItemList.Items[i]));
  end;
  StdItemList.Free;

  for I := 0 to MonsterList.Count - 1 do
  begin
    MonInfo := MonsterList.Items[I];
    if MonInfo.ItemList <> nil then
    begin
      for II := 0 to MonInfo.ItemList.Count - 1 do
      begin
        Dispose(pTMonItem(MonInfo.ItemList.Items[II]));
      end;
      MonInfo.ItemList.Free;
    end;
    Dispose(MonInfo);
  end;
  MonsterList.Free;

  for I := 0 to m_MonGenList.Count - 1 do
  begin
    MonGenInfo := m_MonGenList.Items[I];
    for II := 0 to MonGenInfo.CertList.Count - 1 do
    begin
      TBaseObject(MonGenInfo.CertList.Items[II]).Free;
    end;
    MonGenInfo.CertList.free;                               //hint �ͷ�
    Dispose(pTMonGenInfo(m_MonGenList.Items[I]));

  end;
  m_MonGenList.Free;

  for I := 0 to m_MonFreeList.Count - 1 do
  begin
    TBaseObject(m_MonFreeList.Items[I]).Free;
  end;
  m_MonFreeList.Free;

  for I := 0 to m_MagicList.Count - 1 do
  begin
    Dispose(pTMagic(m_MagicList.Items[i]));
  end;
  m_MagicList.Free;

  for i := 0 to m_AdminList.count - 1 do
  begin                                                     //hint �ͷ�
    Dispose(pTAdminInfo(m_AdminList.Items[i]));
  end;
  m_AdminList.Free;

  for I := 0 to m_MerchantList.Count - 1 do
  begin
    TMerchant(m_MerchantList.Items[i]).Free;
  end;
  m_MerchantList.Free;

  for I := 0 to m_TimerList.Count - 1 do
  begin                                                     //��ʱ��ָ���
    Dispose(pTtimergoto(m_TimerList.Items[i]));
  end;
  m_TimerList.Free;

  for I := 0 to QuestNPCList.Count - 1 do
  begin
    TNormNpc(QuestNPCList.Items[i]).Free;
  end;
  QuestNPCList.Free;
  List_70.Free;
  for I := 0 to m_ChangeServerList.Count - 1 do
  begin
    Dispose(pTSwitchDataInfo(m_ChangeServerList.Items[i]));
  end;
  m_ChangeServerList.Free;
  for I := 0 to m_MagicEventList.Count - 1 do
  begin
    MagicEvent := m_MagicEventList.Items[I];
    if MagicEvent.BaseObjectList <> nil then
      MagicEvent.BaseObjectList.Free;

    Dispose(MagicEvent);
  end;
  m_MagicEventList.Free;
  m_NewHumanList.Free;
  m_ListOfGateIdx.Free;
  m_ListOfSocket.Free;
  for I := 0 to OldMagicList.Count - 1 do
  begin
    tmpList := TList(OldMagicList.Items[I]);
    for II := 0 to tmpList.Count - 1 do
    begin
      Dispose(pTMagic(tmpList.Items[II]));
    end;
    tmpList.Free;
  end;
  OldMagicList.Free;
  DeleteCriticalSection(m_LoadPlaySection);
  inherited;
end;

procedure TUserEngine.Initialize;                           //004B200C
var
  i                                                    : Integer;
  MonGen                                               : pTMonGenInfo;
begin
  MerchantInitialize();
  NPCinitialize();
  for i := 0 to m_MonGenList.Count - 1 do
  begin
    MonGen := m_MonGenList.Items[i];
    if MonGen <> nil then
    begin
      MonGen.nRace := GetMonRace(MonGen.sMonName);
    end;
  end;
end;

function TUserEngine.GetMonNameByRace(btRace: Integer): string;
var
  i                                                    : integer;
  MonInfo                                              : pTMonInfo;
begin
  Result := '';
  for i := 0 to MonsterList.Count - 1 do
  begin
    MonInfo := MonsterList.Items[i];
    if MonInfo.btRace = btRace then
    begin
      Result := MonInfo.sName;
      break;
    end;
  end;
end;

function TUserEngine.GetMonRace(sMonName: string): Integer; //004ACDD8
var
  i                                                    : integer;
  MonInfo                                              : pTMonInfo;
begin
  Result := -1;
  for i := 0 to MonsterList.Count - 1 do
  begin
    MonInfo := MonsterList.Items[i];
    if CompareText(MonInfo.sName, sMonName) = 0 then
    begin
      Result := MonInfo.btRace;
      break;
    end;
  end;
end;

function TUserEngine.GetMonRaceImg(sMonName: string): Integer; //004ACDD8
var
  i                                                    : integer;
  MonInfo                                              : pTMonInfo;
begin
  Result := -1;
  for i := 0 to MonsterList.Count - 1 do
  begin
    MonInfo := MonsterList.Items[i];
    if CompareText(MonInfo.sName, sMonName) = 0 then
    begin
      Result := MonInfo.btRaceImg;
      break;
    end;
  end;
end;

function TUserEngine.GetMonAppr(sMonName: string): Integer; //004ACDD8
var
  i                                                    : integer;
  MonInfo                                              : pTMonInfo;
begin
  Result := -1;
  for i := 0 to MonsterList.Count - 1 do
  begin
    MonInfo := MonsterList.Items[i];
    if CompareText(MonInfo.sName, sMonName) = 0 then
    begin
      Result := MonInfo.wAppr;
      break;
    end;
  end;
end;

procedure TUserEngine.MerchantInitialize;                   //004AC96C
var
  I                                                    : Integer;
  Merchant                                             : TMerchant;
  sCaption                                             : string;
begin
  sCaption := FrmMain.Caption;
  m_MerchantList.Lock;
  try
    for I := m_MerchantList.Count - 1 downto 0 do
    begin
      //for I := 0  to  m_MerchantList.Count - 1 do begin
      Merchant := TMerchant(m_MerchantList.Items[i]);
      Merchant.m_PEnvir := g_MapManager.FindMap(Merchant.m_sMapName);
      if Merchant.m_PEnvir <> nil then
      begin
        Merchant.Initialize;                                //FFFE
        if Merchant.m_boAddtoMapSuccess and (not Merchant.m_boIsHide) then
        begin
          MainOutMessage('Merchant Initalize fail...' + Merchant.m_sCharName + ' ' +
            Merchant.m_sMapName + '(' + IntToStr(Merchant.m_nCurrX) + ':' +
            IntToStr(Merchant.m_nCurrY) + ')');
          m_MerchantList.Delete(i);

          Merchant.Free;
        end
        else
        begin
          Merchant.LoadNPCScript();                         //����NPC �ű�

          Merchant.LoadNPCData();
        end;
      end
      else
      begin
        MainOutMessage(Merchant.m_sCharName +
          'Merchant Initalize fail... (m.PEnvir=nil)');
        m_MerchantList.Delete(i);
        Merchant.Free;
      end;
      FrmMain.Caption := sCaption + '[���ڳ�ʼ����NPC(' + IntToStr(m_MerchantList.Count) +
        '/' + IntToStr(m_MerchantList.Count - I) + ')]';
      //Application.ProcessMessages;
    end;
  finally
    m_MerchantList.UnLock;
  end;
end;

procedure TUserEngine.NPCinitialize;                        //004ACC24
var
  I                                                    : Integer;
  NormNpc                                              : TNormNpc;
begin
  for I := QuestNPCList.Count - 1 downto 0 do
  begin
    NormNpc := TNormNpc(QuestNPCList.Items[i]);
    NormNpc.m_PEnvir := g_MapManager.FindMap(NormNpc.m_sMapName);
    if NormNpc.m_PEnvir <> nil then
    begin
      NormNpc.Initialize;                                   //FFFE
      if NormNpc.m_boAddtoMapSuccess and (not NormNpc.m_boIsHide) then
      begin
        MainOutMessage(NormNpc.m_sCharName + ' Npc Initalize fail... ');
        QuestNPCList.Delete(i);
        NormNpc.Free;
      end
      else
      begin
        NormNpc.LoadNPCScript();
      end;
    end
    else
    begin
      MainOutMessage(NormNpc.m_sCharName + ' Npc Initalize fail... (npc.PEnvir=nil) ');
      QuestNPCList.Delete(i);
      NormNpc.Free;
    end;

  end;
end;

function TUserEngine.GetLoadPlayCount: Integer;             //004AE7F0
begin
  Result := m_LoadPlayList.Count;
end;

function TUserEngine.GetOnlineHumCount: Integer;            //004AE7F0
begin
  Result := m_PlayObjectList.Count;
end;

function TUserEngine.GetUserCount: Integer;                 //004AE7C0
begin
  Result := m_PlayObjectList.Count + m_StringList_0C.Count;
end;

procedure TUserEngine.ProcessHumans;
  function IsLogined(sChrName: string): Boolean;            //004AFC68
  var
    i                                                  : Integer;
  begin
    Result := False;
    if FrontEngine.InSaveRcdList(sChrName) then
    begin
      Result := True;
    end
    else
    begin
      for i := 0 to m_PlayObjectList.Count - 1 do
      begin
        if CompareText(m_PlayObjectList.Strings[i], sChrName) = 0 then
        begin
          Result := True;
          break;
        end;
      end;
    end;
  end;
  function MakeNewHuman(UserOpenInfo: pTUserOpenInfo): TPlayObject; //004AFD28
  var
    PlayObject, hum                                    : TPlayObject;
    Abil                                               : pTAbility;
    Envir                                              : TEnvirnoment;
    nC, nX, nY                                         : integer;
    SwitchDataInfo                                     : pTSwitchDataInfo;
    Castle                                             : TUserCastle;
    canwalk                                            : boolean;
  resourcestring
    sExceptionMsg                                          =
      '[Exception] TUserEngine::MakeNewHuman';
    sChangeServerFail1                                     =
      'chg-server-fail-1 [%d] -> [%d] [%s]';
    sChangeServerFail2                                     =
      'chg-server-fail-2 [%d] -> [%d] [%s]';
    sChangeServerFail3                                     =
      'chg-server-fail-3 [%d] -> [%d] [%s]';
    sChangeServerFail4                                     =
      'chg-server-fail-4 [%d] -> [%d] [%s]';
    sErrorEnvirIsNil                                       =
      '[Error] PlayObject.PEnvir = nil';
  label
    ReGetMap;
  begin
    Result := nil;
    try
      PlayObject := TPlayObject.Create;

      if not g_Config.boVentureServer then
      begin
        UserOpenInfo.sChrName := '';
        UserOpenInfo.LoadUser.nSessionID := 0;
        SwitchDataInfo := GetSwitchData(UserOpenInfo.sChrName,
          UserOpenInfo.LoadUser.nSessionID);
      end
      else
        SwitchDataInfo := nil;                              //004AFD95

      SwitchDataInfo := nil;

      if SwitchDataInfo = nil then
      begin
        GetHumData(PlayObject, UserOpenInfo.HumanRcd);
        //    if not (PlayObject.m_bMaxBagitem in[46,66]) then PlayObject.m_bMaxBagitem:=46;
            //�����ʼ�� ��������������

        PlayObject.m_btRaceServer := RC_PLAYOBJECT;
        if PlayObject.m_sHomeMap = '' then
        begin
          ReGetMap:
          PlayObject.m_sHomeMap := GetHomeInfo(PlayObject.m_nHomeX, PlayObject.m_nHomeY);
          PlayObject.m_sMapName := PlayObject.m_sHomeMap;
          PlayObject.m_nCurrX := GetRandHomeX(PlayObject);
          PlayObject.m_nCurrY := GetRandHomeY(PlayObject);
          if PlayObject.m_Abil.Level = 0 then
          begin
            Abil := @PlayObject.m_Abil;
            Abil.Level := 1;
            Abil.AC := 0;
            Abil.MAC := 0;
            Abil.DC := MakeLong(1, 2);
            Abil.MC := MakeLong(1, 2);
            Abil.SC := MakeLong(1, 2);
            Abil.MP := 15;
            Abil.HP := 15;
            Abil.MaxHP := 15;
            Abil.MaxMP := 15;
            Abil.Exp := 0;
            Abil.MaxExp := 100;
            Abil.Weight := 0;
            Abil.MaxWeight := 30;
            hum := UserEngine.GetPlayObjectEx(PlayObject.sYsnameMaster);
            if hum <> nil then
            begin
              PlayObject.btsex_1 := Hum.btSex_1;
              PlayObject.btJob_1 := Hum.btJob_1;
            end;
            FillChar(PlayObject.btAdditionalAbil, 15, 0);
            PlayObject.m_boNewHuman := True;
          end;
        end;
        Envir := g_MapManager.GetMapInfo(nServerIndex, PlayObject.m_sMapName);
        if Envir <> nil then
        begin
          if Envir.m_boFight3Zone then
          begin                                             //�Ƿ����л�ս����ͼ����
            if (PlayObject.m_Abil.HP <= 0) and (PlayObject.m_nFightZoneDieCount < 3) then
            begin
              PlayObject.m_Abil.HP := PlayObject.m_Abil.MaxHP;
              PlayObject.m_Abil.MP := PlayObject.m_Abil.MaxMP;
              PlayObject.m_boDieInFight3Zone := True;
            end
            else
              PlayObject.m_nFightZoneDieCount := 0;
          end;
        end;

        PlayObject.m_MyGuild := g_GuildManager.MemberOfGuild(PlayObject.m_sCharName);
        Castle := g_CastleManager.InCastleWarArea(Envir, PlayObject.m_nCurrX,
          PlayObject.m_nCurrY);
        {
        if (Envir <> nil) and ((UserCastle.m_MapPalace = Envir) or
          (UserCastle.m_boUnderWar and UserCastle.InCastleWarArea(PlayObject.m_PEnvir,PlayObject.m_nCurrX,PlayObject.m_nCurrY))) then begin
        }
        if (Envir <> nil) and (Castle <> nil) and ((Castle.m_MapPalace = Envir) or
          Castle.m_boUnderWar) then
        begin
          Castle := g_CastleManager.IsCastleMember(PlayObject);

          //if not UserCastle.IsMember(PlayObject) then begin
          if Castle = nil then
          begin
            PlayObject.m_sMapName := PlayObject.m_sHomeMap;
            PlayObject.m_nCurrX := PlayObject.m_nHomeX - 2 + Random(5);
            PlayObject.m_nCurrY := PlayObject.m_nHomeY - 2 + Random(5);
          end
          else
          begin
            {
            if UserCastle.m_MapPalace = Envir then begin
              PlayObject.m_sMapName:=UserCastle.GetMapName();
              PlayObject.m_nCurrX:=UserCastle.GetHomeX;
              PlayObject.m_nCurrY:=UserCastle.GetHomeY;
            end;
            }
            if Castle.m_MapPalace = Envir then
            begin
              PlayObject.m_sMapName := Castle.GetMapName();
              PlayObject.m_nCurrX := Castle.GetHomeX;
              PlayObject.m_nCurrY := Castle.GetHomeY;
            end;

          end;
        end;                                                //004B00C0

        if g_MapManager.FindMap(PlayObject.m_sMapName) = nil then
          PlayObject.m_Abil.HP := 0;
        if PlayObject.m_Abil.HP <= 0 then
        begin
          PlayObject.ClearStatusTime();
          if PlayObject.PKLevel < 2 then
          begin
            Castle := g_CastleManager.IsCastleMember(PlayObject);
            //            if UserCastle.m_boUnderWar and (UserCastle.IsMember(PlayObject)) then begin
            if (Castle <> nil) and Castle.m_boUnderWar then
            begin
              PlayObject.m_sMapName := Castle.m_sHomeMap;
              PlayObject.m_nCurrX := Castle.GetHomeX;
              PlayObject.m_nCurrY := Castle.GetHomeY;
            end
            else
            begin
              PlayObject.m_sMapName := PlayObject.m_sHomeMap;
              PlayObject.m_nCurrX := PlayObject.m_nHomeX - 2 + Random(5);
              PlayObject.m_nCurrY := PlayObject.m_nHomeY - 2 + Random(5);
            end;
          end
          else
          begin                                             //004B0201
            PlayObject.m_sMapName := g_Config.sRedDieHomeMap {'3'};
            PlayObject.m_nCurrX := Random(13) + g_Config.nRedDieHomeX {839};
            PlayObject.m_nCurrY := Random(13) + g_Config.nRedDieHomeY {668};
          end;
          PlayObject.m_Abil.HP := 14;
        end;                                                //004B023D

        PlayObject.AbilCopyToWAbil();
        Envir := g_MapManager.GetMapInfo(nServerIndex, PlayObject.m_sMapName);
        if Envir = nil then
        begin
          PlayObject.m_nSessionID := UserOpenInfo.LoadUser.nSessionID;
          PlayObject.m_nSocket := UserOpenInfo.LoadUser.nSocket;
          PlayObject.m_nGateIdx := UserOpenInfo.LoadUser.nGateIdx;
          PlayObject.m_nGSocketIdx := UserOpenInfo.LoadUser.nGSocketIdx;
          PlayObject.m_WAbil := PlayObject.m_Abil;
          PlayObject.m_nServerIndex :=
            g_MapManager.GetMapOfServerIndex(PlayObject.m_sMapName);
          if PlayObject.m_Abil.HP <> 14 then
          begin                                             // 14
            MainOutMessage(format(sChangeServerFail1, [nServerIndex,
              PlayObject.m_nServerIndex, PlayObject.m_sMapName]));
            {MainOutMessage('chg-server-fail-1 [' +
                           IntToStr(nServerIndex) +
                           '] -> [' +
                           IntToStr(PlayObject.m_nServerIndex) +
                           '] [' +
                           PlayObject.m_sMapName +
                           ']');}
          end;
          SendSwitchData(PlayObject, PlayObject.m_nServerIndex);
          SendChangeServer(PlayObject, PlayObject.m_nServerIndex);
          PlayObject.Free;
          MainOutMessage('HiTe:PlayObject Free');
          exit;
        end;
        nC := 0;
        canwalk := false;
        if PlayObject.sYsnameMaster <> '' then
        begin                                               //�����Ԫ��
          PlayObject.ysmasterplayer := nil;
          hum := nil;
          hum := UserEngine.GetPlayObjectEx(PlayObject.sYsnameMaster);
          if hum <> nil then
          begin
            Envir := hum.m_PEnvir;
            hum.GetFrontPosition(nX, nY);
            PlayObject.m_nCurrX := nX;
            PlayObject.m_nCurrY := nY;
            PlayObject.ysmasterplayer := hum;               //��������Ԫ���ϵ
            hum.Ysplayer := PlayObject;
            hum.nyssex := PlayObject.m_btGender;            //Ԫ���Ա�
            hum.wyslevel := PlayObject.m_Abil.Level;        //Ԫ��Ǽ�
            hum.nysjob := PlayObject.m_btjob;               //Ԫ��ְҵ
            //   PlayObject.M_YSfenghao := hum.M_YSfenghao; //Ԫ��ķ�ű�������������

          end;

          while (True) do
          begin                                             //004B03CC
            if Envir.CanWalk(PlayObject.m_nCurrX, PlayObject.m_nCurrY, True) then
            begin
              canwalk := true;
              break;
            end;
            PlayObject.m_nCurrX := PlayObject.m_nCurrX - 3 + Random(6);
            PlayObject.m_nCurrY := PlayObject.m_nCurrY - 3 + Random(6);

            Inc(nC);
            if nC >= 10 then
              break;
          end;                                              //true

        end                                                 //�����Ԫ��
        else
        begin
          while (True) do
          begin                                             //004B03CC
            if Envir.CanWalk(PlayObject.m_nCurrX, PlayObject.m_nCurrY, True) then
            begin
              canwalk := true;
              break;
            end;
            PlayObject.m_nCurrX := PlayObject.m_nCurrX - 3 + Random(6);
            PlayObject.m_nCurrY := PlayObject.m_nCurrY - 3 + Random(6);

            Inc(nC);
            if nC >= 5 then
              break;
          end;
        end;                                                //else

        if not canwalk then
        begin // Envir.CanWalk(PlayObject.m_nCurrX,PlayObject.m_nCurrY,True)
          //   MainOutMessage(format(sChangeServerFail2,[nServerIndex,PlayObject.m_nServerIndex,PlayObject.m_sMapName]));
             {  MainOutMessage('chg-server-fail-2 [' +
                              IntToStr(nServerIndex) +
                              '] -> [' +
                              IntToStr(PlayObject.m_nServerIndex) +
                              '] [' +
                              PlayObject.m_sMapName +
                              ']');}
          PlayObject.m_sMapName := g_Config.sHomeMap;
          Envir := g_MapManager.FindMap(g_Config.sHomeMap);
          PlayObject.m_nCurrX := g_Config.nHomeX;
          PlayObject.m_nCurrY := g_Config.nHomeY;
        end;

        PlayObject.m_PEnvir := Envir;
        if PlayObject.m_PEnvir = nil then
        begin
          MainOutMessage(sErrorEnvirIsNil);
          goto ReGetMap;
        end
        else
        begin
          PlayObject.m_boReadyRun := False;
        end;

      end
      else
      begin                                                 //004B0561
        GetHumData(PlayObject, UserOpenInfo.HumanRcd);
        PlayObject.m_sMapName := SwitchDataInfo.sMap;
        PlayObject.m_nCurrX := SwitchDataInfo.wX;
        PlayObject.m_nCurrY := SwitchDataInfo.wY;
        PlayObject.m_Abil := SwitchDataInfo.Abil;
        PlayObject.m_WAbil := SwitchDataInfo.Abil;
        LoadSwitchData(SwitchDataInfo, PlayObject);
        DelSwitchData(SwitchDataInfo);
        Envir := g_MapManager.GetMapInfo(nServerIndex, PlayObject.m_sMapName);
        if Envir <> nil then
        begin
          MainOutMessage(format(sChangeServerFail3, [nServerIndex,
            PlayObject.m_nServerIndex, PlayObject.m_sMapName]));
          {MainOutMessage('chg-server-fail-3 [' +
                         IntToStr(nServerIndex) +
                         '] -> [' +
                         IntToStr(PlayObject.m_nServerIndex) +
                         '] [' +
                         PlayObject.m_sMapName +
                         ']');}
          PlayObject.m_sMapName := g_Config.sHomeMap;
          Envir := g_MapManager.FindMap(g_Config.sHomeMap);
          PlayObject.m_nCurrX := g_Config.nHomeX;
          PlayObject.m_nCurrY := g_Config.nHomeY;
        end
        else
        begin
          if not Envir.CanWalk(PlayObject.m_nCurrX, PlayObject.m_nCurrY, True) then
          begin
            MainOutMessage(format(sChangeServerFail4, [nServerIndex,
              PlayObject.m_nServerIndex, PlayObject.m_sMapName]));
            {MainOutMessage('chg-server-fail-4 [' +
                           IntToStr(nServerIndex) +
                           '] -> [' +
                           IntToStr(PlayObject.m_nServerIndex) +
                           '] [' +
                           PlayObject.m_sMapName +
                           ']');}
            PlayObject.m_sMapName := g_Config.sHomeMap;
            Envir := g_MapManager.FindMap(g_Config.sHomeMap);
            PlayObject.m_nCurrX := g_Config.nHomeX;
            PlayObject.m_nCurrY := g_Config.nHomeY;
          end;
          PlayObject.AbilCopyToWAbil();
          PlayObject.m_PEnvir := Envir;
          if PlayObject.m_PEnvir = nil then
          begin
            MainOutMessage(sErrorEnvirIsNil);
            goto ReGetMap;
          end
          else
          begin
            PlayObject.m_boReadyRun := False;
            PlayObject.m_boLoginNoticeOK := True;
            PlayObject.bo6AB := True;
          end;
        end;
      end;                                                  //004B085C
      PlayObject.m_sUserID := UserOpenInfo.LoadUser.sAccount;
      PlayObject.m_sIPaddr := UserOpenInfo.LoadUser.sIPaddr;
      PlayObject.m_sIPLocal := GetIPLocal(PlayObject.m_sIPaddr);
      PlayObject.m_nSocket := UserOpenInfo.LoadUser.nSocket;
      PlayObject.m_nGSocketIdx := UserOpenInfo.LoadUser.nGSocketIdx;
      PlayObject.m_nGateIdx := UserOpenInfo.LoadUser.nGateIdx;
      PlayObject.m_nSessionID := UserOpenInfo.LoadUser.nSessionID;
      PlayObject.m_nPayMent := UserOpenInfo.LoadUser.nPayMent;
      PlayObject.m_nPayMode := UserOpenInfo.LoadUser.nPayMode;
      PlayObject.m_dwLoadTick := UserOpenInfo.LoadUser.dwNewUserTick;
      //      PlayObject.m_nSoftVersionDate:=UserOpenInfo.HumInfo.nSoftVersionDate;
      PlayObject.m_nSoftVersionDateEx :=
        GetExVersionNO(UserOpenInfo.LoadUser.nSoftVersionDate,
        PlayObject.m_nSoftVersionDate);
      Result := PlayObject;
    except
      MainOutMessage(sExceptionMsg);
    end;
  end;
var
  dwUsrRotTime                                         : LongWord;
  dwCheckTime                                          : LongWord; //0x10
  dwCurTick                                            : LongWord;
  nCheck30                                             : Integer; //0x30
  boCheckTimeLimit                                     : Boolean; //0x31
  nIdx                                                 : Integer;
  PlayObject, hum                                      : TPlayObject;
  I                                                    : Integer;
  UserOpenInfo                                         : pTUserOpenInfo;
  GoldChangeInfo                                       : pTGoldChangeInfo;
  LineNoticeMsg                                        : string;
  // nx,ny:integer;

resourcestring
  sExceptionMsg1                                         =
    '[Exception] TUserEngine::ProcessHumans -> Ready, Save, Load... Code:=%d';
  sExceptionMsg2                                         =
    '[Exception] TUserEngine::ProcessHumans ClosePlayer.Delete - Free';
  sExceptionMsg3                                         =
    '[Exception] TUserEngine::ProcessHumans ClosePlayer.Delete';
  sExceptionMsg4                                         =
    '[Exception] TUserEngine::ProcessHumans RunNotice';
  sExceptionMsg5                                         =
    '[Exception] TUserEngine::ProcessHumans Human.Operate Code: %d';
  sExceptionMsg6                                         =
    '[Exception] TUserEngine::ProcessHumans Human.Finalize Code: %d';
  sExceptionMsg7                                         =
    '[Exception] TUserEngine::ProcessHumans RunSocket.CloseUser Code: %d';
  sExceptionMsg8                                         =
    '[Exception] TUserEngine::ProcessHumans  Code: %d';
begin
  nCheck30 := 0;
  dwCheckTime := GetTickCount();
  if (GetTickCount - m_dwProcessLoadPlayTick) > 200 then
  begin
    m_dwProcessLoadPlayTick := GetTickCount();
    try
      EnterCriticalSection(m_LoadPlaySection);
      try

        for i := 0 to m_LoadPlayList.Count - 1 do
        begin
          if not FrontEngine.IsFull and not IsLogined(m_LoadPlayList.Strings[i]) then
          begin
            UserOpenInfo := pTUserOpenInfo(m_LoadPlayList.Objects[i]);

            PlayObject := MakeNewHuman(UserOpenInfo);

            if PlayObject <> nil then
            begin
              //PlayObject.m_boClientFlag:=UserOpenInfo.LoadUser.boClinetFlag; //���ͻ��˱�־��������������
              m_PlayObjectList.AddObject(m_LoadPlayList.Strings[i], PlayObject);
              SendServerGroupMsg(SS_201, nServerIndex, PlayObject.m_sCharName);
              m_NewHumanList.Add(PlayObject);
            end;

          end
          else
          begin                                             //004B0BF9
            KickOnlineUser(m_LoadPlayList.Strings[i]);
            UserOpenInfo := pTUserOpenInfo(m_LoadPlayList.Objects[i]);
            m_ListOfGateIdx.Add(Pointer(UserOpenInfo.LoadUser.nGateIdx)); //004B0C39
            m_ListOfSocket.Add(Pointer(UserOpenInfo.LoadUser.nSocket));
          end;
          Dispose(pTUserOpenInfo(m_LoadPlayList.Objects[I]));
        end;                                                //004B0C96
        m_LoadPlayList.Clear;
        for I := 0 to m_ChangeHumanDBGoldList.Count - 1 do
        begin
          GoldChangeInfo := m_ChangeHumanDBGoldList.Items[I];
          PlayObject := GeTPlayObject(GoldChangeInfo.sGameMasterName);
          if PlayObject <> nil then
          begin
            PlayObject.GoldChange(GoldChangeInfo.sGetGoldUser, GoldChangeInfo.nGold);
          end;
          Dispose(GoldChangeInfo);
        end;
        m_ChangeHumanDBGoldList.Clear;
      finally
        LeaveCriticalSection(m_LoadPlaySection);
      end;

      //004B0D4A
      for I := 0 to m_NewHumanList.Count - 1 do
      begin
        PlayObject := TPlayObject(m_NewHumanList.Items[I]);

        RunSocket.SetGateUserList(PlayObject.m_nGateIdx, PlayObject.m_nSocket,
          PlayObject);

      end;
      m_NewHumanList.Clear;

      for i := 0 to m_ListOfGateIdx.Count - 1 do
      begin

        RunSocket.CloseUser(Integer(m_ListOfGateIdx.Items[i]),
          Integer(m_ListOfSocket.Items[i]));                  //GateIdx,nSocket
        //  MainOutMessage('xjs:close3 then RunSocket.CloseUser');
      end;
      m_ListOfGateIdx.Clear;
      m_ListOfSocket.Clear;
    except
      on e: Exception do
      begin
        MainOutMessage(format(sExceptionMsg1, [0]));
        MainOutMessage(E.Message);
        raise;
      end;

    end;
  end;                                                      //004B0E1E

  try
    for I := 0 to m_PlayObjectFreeList.Count - 1 do
    begin
      PlayObject := TPlayObject(m_PlayObjectFreeList.Items[i]);
      if (GetTickCount - PlayObject.m_dwGhostTick) > g_Config.dwHumanFreeDelayTime
        {5 * 60 * 1000} then
      begin
        try

          TPlayObject(m_PlayObjectFreeList.Items[i]).Free;
          PlayObject := nil;
        except
          MainOutMessage(sExceptionMsg2);
        end;

        m_PlayObjectFreeList.Delete(i);
        break;
      end
      else
      begin
        if PlayObject.m_boSwitchData and (PlayObject.m_boRcdSaved) then
        begin
          if SendSwitchData(PlayObject, PlayObject.m_nServerIndex) or
            (PlayObject.m_nWriteChgDataErrCount > 20) then
          begin
            PlayObject.m_boSwitchData := False;
            PlayObject.m_boSwitchDataSended := True;
            PlayObject.m_dwChgDataWritedTick := GetTickCount();
          end
          else
            Inc(PlayObject.m_nWriteChgDataErrCount);
        end;
        if PlayObject.m_boSwitchDataSended and ((GetTickCount -
          PlayObject.m_dwChgDataWritedTick) > 100) then
        begin
          PlayObject.m_boSwitchDataSended := False;
          SendChangeServer(PlayObject, PlayObject.m_nServerIndex);
        end;
      end;
    end;
  except
    MainOutMessage(sExceptionMsg3);
  end;                                                      //004B0F91

  boCheckTimeLimit := False;                                //004B0F91
  try
    dwCurTick := GetTickCount();
    nIdx := m_nProcHumIDx;
    while True do
    begin
      if m_PlayObjectList.Count <= nIdx then
        break;

      PlayObject := TPlayObject(m_PlayObjectList.Objects[nIdx]);
      if Integer(dwCurTick - PlayObject.m_dwRunTick) > PlayObject.m_nRunTime then
      begin
        PlayObject.m_dwRunTick := dwCurTick;

        if (PlayObject.m_boDeath) or (PlayObject.m_boGhost) then
        begin
          if not PlayObject.m_boDeathRcdSaved then
          begin
            SaveHumanRcd(PlayObject);
            PlayObject.m_boDeathRcdSaved := true;
          end;
        end;

        if not PlayObject.m_boGhost then
        begin
          if not PlayObject.m_boLoginNoticeOK then
          begin
{$IF CATEXCEPTION = TRYEXCEPTION}
            try
{$IFEND}                                                    //  PlayObject.SendLogon ;

              PlayObject.RunNotice();
{$IF CATEXCEPTION = TRYEXCEPTION}
            except
              MainOutMessage(sExceptionMsg4);
            end;
{$IFEND}
          end
          else
          begin                                             //004B1058
            try
              if not PlayObject.m_boReadyRun then
              begin
                PlayObject.m_boReadyRun := True;            //004B1075
                PlayObject.SendDefMessage(1809, 0, 0, 0, 0, '');
                PlayObject.SendDefMessage(38291, integer(PlayObject), 1, 0, 0, '');
                PlayObject.SendDefMessage(38291, integer(PlayObject), 2, 0, 0, '');
                PlayObject.SendDefMessage(1840, Integer(PlayObject), 3, 0, 6,
                  'tvfmyvfmmvfqcvfmXvfy@vfm', True);

                if PlayObject.sYsnameMaster <> '' then
                begin                                       //˵����Ԫ��
                  hum := nil;
                  //  hum:=UserEngine.GetPlayObjectEx(PlayObject.sYsnameMaster);
                  hum := PlayObject.ysmasterplayer;
                  if hum <> nil then
                  begin

                    PlayObject.SendDefMessage(38292, integer(PlayObject), 0, 40, 0, '');  //�����Ĵ�С
                    PlayObject.SendDefMessage(38291, integer(PlayObject), 4, 0, 0, '');  //�����Ĵ�С

                    PlayObject.SendDefMessage(38294, 0, 0, 0, 0, ''); //�����б�
                    PlayObject.SendDefMessage(21292,
                      Integer(PlayObject),
                      8, //makeword(8,PlayObject.m_nfenghaolevel),
                      PlayObject.GetYSfenghao(PlayObject.M_YSfenghao), // 0 1 2 3 4
                      0,
                      '');                                  // PlayObject.m_sfenghao

                    // PlayObject.SendDefMessage(38294,PlayObject.m_btGender,PlayObject.m_btGender,PlayObject.m_btGender,PlayObject.m_btGender,'');

                    PlayObject.nyuanqi := 0;
                    PlayObject.SendDefMessage(38417, 0, 0, 100, 0, '');
                    PlayObject.m_boStartshow := true;
                    inc(hum.m_nYsCallcount);
                    PlayObject.SendRefMsg(RM_510, 0, 1, 0, 22, '');
                  end;                                      //hum<>nil
                end; //  PlayObject.sYsnameMaster<>''

                PlayObject.UserLogon;                       //BaseObject.0FFFEh;

              end
              else
              begin
                if (GetTickCount() - PlayObject.m_dwSearchTick) >
                  PlayObject.m_dwSearchTime then
                begin
                  PlayObject.m_dwSearchTick := GetTickCount();
                  PlayObject.SearchViewRange;
                  PlayObject.GameTimeChanged;
                end;                                        //004B10C4
                /////////////   ���
                if PlayObject.sYsnameMaster = '' then
                begin
                  if (GetTickCount - PlayObject.m_dwShowBannerNoticeTime >
                    g_Config.HideBannerNoticeTime) and (not PlayObject.m_boshowBanner) then
                  begin
                    PlayObject.m_dwShowBannerNoticeTime := GetTickCount();
                    //    PlayObject.m_dwHideBannerNoticeTime:= GetTickCount();
                    if BannerNotice.Count > PlayObject.m_nShowBannerNoticeIdx then
                    begin
                      LineNoticeMsg := g_ManageNPC.GetLineVariableText(PlayObject,
                        BannerNotice.Strings[PlayObject.m_nShowBannerNoticeIdx]);

                      PlayObject.SendDefMessage(100, 0, 38656, 10, 768, LineNoticeMsg);  //���  ��ʾ
                      PlayObject.m_boshowBanner := true;
                    end;
                    Inc(PlayObject.m_nShowBannerNoticeIdx);
                    if (BannerNotice.Count <= PlayObject.m_nShowBannerNoticeIdx) then
                      PlayObject.m_nShowBannerNoticeIdx := 0;

                  end;

                  if (GetTickCount - PlayObject.m_dwShowBannerNoticeTime >
                    g_Config.ShowBannerNoticeTime) and (PlayObject.m_boshowBanner) then
                  begin
                    //  PlayObject.m_dwHideBannerNoticeTime:= GetTickCount();
                    PlayObject.m_dwShowBannerNoticeTime := GetTickCount();
                    PlayObject.SendDefMessage(100, 0, 38656, 10, 768, ''); //��� ����
                    PlayObject.m_boshowBanner := false;
                  end;
                  //  if PlayObject.sYsnameMaster='' then  begin

                    ///////////////
                  if (GetTickCount() - PlayObject.m_dwShowLineNoticeTick) >
                    g_Config.dwShowLineNoticeTime then
                  begin
                    PlayObject.m_dwShowLineNoticeTick := GetTickCount();
                    if LineNoticeList.Count > PlayObject.m_nShowLineNoticeIdx then
                    begin

                      LineNoticeMsg := g_ManageNPC.GetLineVariableText(PlayObject,
                        LineNoticeList.Strings[PlayObject.m_nShowLineNoticeIdx]);

                      //PlayObject.SysMsg(g_Config.sLineNoticePreFix + ' '+ LineNoticeList.Strings[PlayObject.m_nShowLineNoticeIdx],g_nLineNoticeColor);

                      case LineNoticeMsg[1] of
                        'R': PlayObject.SysMsg(Copy(LineNoticeMsg, 2,
                          length(LineNoticeMsg) - 1), c_Red, t_Notice);
                        'G': PlayObject.SysMsg(Copy(LineNoticeMsg, 2,
                          length(LineNoticeMsg) - 1), c_Green, t_Notice);
                        'B': PlayObject.SysMsg(Copy(LineNoticeMsg, 2,
                          length(LineNoticeMsg) - 1), c_Blue, t_Notice);
                      else
                        begin
                          PlayObject.SysMsg(LineNoticeMsg,
                            TMsgColor(g_Config.nLineNoticeColor) {c_Blue}, t_Notice);
                        end;
                      end;
                    end;
                    Inc(PlayObject.m_nShowLineNoticeIdx);
                    if (LineNoticeList.Count <= PlayObject.m_nShowLineNoticeIdx) then
                      PlayObject.m_nShowLineNoticeIdx := 0;
                  end;
                end;
                PlayObject.Run();

                if not FrontEngine.IsFull and ((GetTickCount() -
                  PlayObject.m_dwSaveRcdTick) > g_Config.dwSaveHumanRcdTime) then
                begin
                  PlayObject.m_dwSaveRcdTick := GetTickCount();

                  PlayObject.DealCancelA();

                  SaveHumanRcd(PlayObject);

                end;
              end;                                          //004B119F
            except
              on e: Exception do
              begin
                MainOutMessage(format(sExceptionMsg5, [0]));
                MainOutMessage(E.Message);
                raise;
              end;

            end;
          end;
        end
        else
        begin //if not PlayObject.boIsGhost then begin  //CODE:004B11C5
          //  if not (PlayObject.InSafeZone and (PlayObject.m_boSoftClose)) then
          begin
            try

              m_PlayObjectList.Delete(nIdx);
              nCheck30 := 2;

              PlayObject.Disappear();

              nCheck30 := 3;
            except
              on e: Exception do
              begin
                MainOutMessage(format(sExceptionMsg6, [nCheck30]));
                MainOutMessage(E.Message);
                raise;
              end;

            end;                                            //004B1232
            try
              //�����������
              AddToHumanFreeList(PlayObject);

              nCheck30 := 4;
              PlayObject.DealCancelA();

              //  SaveHumanRcd(PlayObject);
            //   if PlayObject.sYsnameMaster='' then  begin//���������Ļ�Ҫ����
             //   MainOutMessage('xjs:if sYsnameMaster=0 then RunSocket.CloseUser');

       //         PlayObject.MakeGhost;

            except
              MainOutMessage(format(sExceptionMsg7, [nCheck30]));
            end;                                            //004B12BA
          end;
          RunSocket.CloseUser(PlayObject.m_nGateIdx, PlayObject.m_nSocket);  //        ���1.9 �汾�����
          SendServerGroupMsg(SS_202, nServerIndex, PlayObject.m_sCharName);
          Continue;
        end;
      end; //if (dwTime14 - PlayObject.dw368) > PlayObject.dw36C then begin
      Inc(nIdx);                                            //004B12E6
      if (GetTickCount - dwCheckTime) > g_dwHumLimit then
      begin
        boCheckTimeLimit := True;
        m_nProcHumIDx := nIdx;
        break;
      end;
    end;                                                    //while True do begin
    if not boCheckTimeLimit then
      m_nProcHumIDx := 0;
  except
    // MainOutMessage(sExceptionMsg8);
    on e: Exception do
    begin
      MainOutMessage(format(sExceptionMsg8, [nCheck30]));
      MainOutMessage(E.Message);
      raise;
    end;

  end;
  Inc(nProcessHumanLoopTime);
  g_nProcessHumanLoopTime := nProcessHumanLoopTime;
  if m_nProcHumIDx = 0 then
  begin
    nProcessHumanLoopTime := 0;
    g_nProcessHumanLoopTime := nProcessHumanLoopTime;
    dwUsrRotTime := GetTickCount - g_dwUsrRotCountTick;
    dwUsrRotCountMin := dwUsrRotTime;
    g_dwUsrRotCountTick := GetTickCount();
    if dwUsrRotCountMax < dwUsrRotTime then
      dwUsrRotCountMax := dwUsrRotTime;
  end;
  g_nHumCountMin := GetTickCount - dwCheckTime;
  if g_nHumCountMax < g_nHumCountMin then
    g_nHumCountMax := g_nHumCountMin;
  asm
      NOP; NOP; NOP; NOP; NOP; NOP; NOP; NOP; NOP; NOP;
  end;
end;

procedure TUserEngine.ProcessMerchants;                     //004B1B8C
var
  dwRunTick, dwCurrTick                                : LongWord;
  i                                                    : integer;
  MerchantNPC                                          : TMerchant;
  boProcessLimit                                       : Boolean;
resourcestring
  sExceptionMsg                                          =
    '[Exception] TUserEngine::ProcessMerchants';
begin
  dwRunTick := GetTickCount();
  boProcessLimit := False;
  try
    dwCurrTick := GetTickCount();
    m_MerchantList.Lock;
    try
      for i := nMerchantPosition to m_MerchantList.Count - 1 do
      begin
        MerchantNPC := m_MerchantList.Items[i];
        if not MerchantNPC.m_boGhost then
        begin
          if Integer(dwCurrTick - MerchantNPC.m_dwRunTick) > MerchantNPC.m_nRunTime then
          begin
            if (GetTickCount - MerchantNPC.m_dwSearchTick) > MerchantNPC.m_dwSearchTime
              then
            begin
              MerchantNPC.m_dwSearchTick := GetTickCount();
              MerchantNPC.SearchViewRange();
            end;                                            //004B1C3C
            if Integer(dwCurrTick - MerchantNPC.m_dwRunTick) > MerchantNPC.m_nRunTime
              then
            begin
              MerchantNPC.m_dwRunTick := dwCurrTick;
              MerchantNPC.Run;                              {FFFFB}
            end;
          end;                                              //004B1C6B
        end
        else
        begin                                               //004B1C6B
          if (GetTickCount - MerchantNPC.m_dwGhostTick) > 60 * 1000 then
          begin
            // MerchantNPC.Free;
            FreeAndNil(MerchantNPC);
            m_MerchantList.Delete(i);
            break;
          end;
        end;
        if (GetTickCount - dwRunTick) > g_dwNpcLimit then
        begin
          nMerchantPosition := i;
          boProcessLimit := True;
          Break;
        end;                                                //004B1C8C
      end;                                                  //004B1C98
    finally
      m_MerchantList.UnLock;
    end;
    if not boProcessLimit then
    begin
      nMerchantPosition := 0;
    end;                                                    //004B1CA6
  except
    MainOutMessage(sExceptionMsg);
  end;
  dwProcessMerchantTimeMin := GetTickCount - dwRunTick;
  if dwProcessMerchantTimeMin > dwProcessMerchantTimeMax then
    dwProcessMerchantTimeMax := dwProcessMerchantTimeMin;
  if dwProcessNpcTimeMin > dwProcessNpcTimeMax then
    dwProcessNpcTimeMax := dwProcessNpcTimeMin;
end;

procedure TUserEngine.ProcessMissions;
var
  Startuphum                                           : Tplayobject;
  sMapName                                             : string;
  nSafePoint, nSafeX, nSafeY                           : integer;
  Envir                                                : TEnvirnoment;
  SafeZoneLight                                        : TSafeZoneLight;
  nx, ny, i                                            : integer;
  sList                                                : TStringList;
  sMonName, sMonName1, sX, sY, sDir, sDate, sDayCount  : string;
  nTime                                                : TDateTime;
  Mon                                                  : TBaseObject;
begin
  if g_bostartup then
  begin
    if FileExists(g_Config.sEnvirDir + '\MonLifeSpan.TXT') then
    begin
      try
        sList := TStringList.Create;
        sList.LoadFromFile(g_Config.sEnvirDir + '\MonLifeSpan.TXT');
        for I := sList.Count - 1 downto 0 do
        begin
          sDate := Trim(sList[i]);
          if sDate = '' then Continue;
          if sDate[1] = ';' then Continue;
          sDate := GetValidStr3(sDate, sMonName, [#9, ' ']);
          sDate := GetValidStr3(sDate, sMonName1, [#9, ' ']);
          sDate := GetValidStr3(sDate, sMapName, [#9, ' ']);
          sDate := GetValidStr3(sDate, sx, [#9, ' ']);
          sDate := GetValidStr3(sDate, sy, [#9, ' ']);
          sDate := GetValidStr3(sDate, sDir, [#9, ' ']);
          sDate := GetValidStr3(sDate, sDayCount, [#9, ' ']);
          nTime := StrToDateTimeDef(sDate, 0);

          if (nTime = 0) or (Now() > nTIme + Str_ToInt(sDayCount, 0)) then
          begin
            sList.Delete(i);
            Continue;
          end;
          Mon := UserEngine.RegenMonsterByName(sMapName, Str_ToInt(sx, 0), Str_ToInt(sy,
            0), sMonName);
          if Mon <> nil then
          begin
            Mon.m_sOldName := Mon.m_sCharName;
            Mon.m_sCharName := sMonName1;
            Mon.m_nDieTime := nTime;
            Mon.m_nDieDay := Str_ToInt(sDayCount, 0);
          end;

        end;
      finally
        sList.SaveToFile(g_Config.sEnvirDir + '\MonLifeSpan.TXT');
        sList.Free;
      end;
    end;

    if g_ManageNPC <> nil then
    begin
      Startuphum := Tplayobject.Create;
      if Startuphum <> nil then
      begin
        Startuphum.m_sCharName := 'Startup';
        Startuphum.m_sMapName := '0';
        Startuphum.m_PEnvir := g_MapManager.FindMap(Startuphum.m_sMapName);
        g_ManageNPC.GotoLable(Startuphum, '@GlobalVar', False);
        g_ManageNPC.GotoLable(Startuphum, '@GuildVar', False);
        g_bostartup := false;
        Startuphum.Free;
      end;
    end;

    if g_Config.boUseSafeZoneLight then
    begin
      try
        g_StartPointList.Lock;
        for I := 0 to g_StartPointList.Count - 1 do
        begin
          sMapName := g_StartPointList.Strings[i];
          nSafePoint := Integer(g_StartPointList.Objects[i]);
          nSafeX := LoWord(nSafePoint);
          nSafeY := HiWord(nSafePoint);
          Envir := g_MapManager.FindMap(sMapName);
          if Envir = nil then
            Continue;
          /////////////
          nY := nSafeY - g_Config.nSafeZoneSize;
          nX := nSafeX - g_Config.nSafeZoneSize;
          while nX < nSafeX + g_Config.nSafeZoneSize do
          begin

            if Envir.GetEvent(nX, nY) = nil then
            begin
              SafeZoneLight := TSafeZoneLight.Create(Envir, nX, nY, ET_HOLYCURTAIN, 10 *
                24 * 60 * 60 * 1000, 0);
              g_EventManager.AddEvent(SafeZoneLight);
            end;
            inc(nx, 2);
          end;                                              //while
          nx := nSafeX + g_Config.nSafeZoneSize;
          if (Envir.GetEvent(nx, ny) = nil) and Envir.CanWalk(nX, nY, false) then
          begin
            SafeZoneLight := TSafeZoneLight.Create(Envir, nX, nY, ET_HOLYCURTAIN, 10 * 24
              * 60 * 60 * 1000, 0);
            g_EventManager.AddEvent(SafeZoneLight);
          end;

          nY := nSafeY + g_Config.nSafeZoneSize;
          nX := nSafeX - g_Config.nSafeZoneSize;
          while nX < nSafeX + g_Config.nSafeZoneSize do
          begin

            if (Envir.GetEvent(nX, nY) = nil) and Envir.CanWalk(nX, nY, false) then
            begin
              SafeZoneLight := TSafeZoneLight.Create(Envir, nX, nY, ET_HOLYCURTAIN, 10 *
                24 * 60 * 60 * 1000, 0);
              g_EventManager.AddEvent(SafeZoneLight);
            end;
            inc(nx, 2);
          end;                                              //while
          nx := nSafeX + g_Config.nSafeZoneSize;
          if (Envir.GetEvent(nx, ny) = nil) and Envir.CanWalk(nX, nY, false) then
          begin
            SafeZoneLight := TSafeZoneLight.Create(Envir, nX, nY, ET_HOLYCURTAIN, 10 * 24
              * 60 * 60 * 1000, 0);
            g_EventManager.AddEvent(SafeZoneLight);
          end;

          // ==============
          nY := nSafeY - g_Config.nSafeZoneSize;
          nX := nSafeX - g_Config.nSafeZoneSize;
          while ny < nSafey + g_Config.nSafeZoneSize do
          begin

            if (Envir.GetEvent(nx, ny) = nil) and Envir.CanWalk(nX, nY, false) then
            begin
              SafeZoneLight := TSafeZoneLight.Create(Envir, nX, nY, ET_HOLYCURTAIN, 10 *
                24 * 60 * 60 * 1000, 0);
              g_EventManager.AddEvent(SafeZoneLight);
            end;
            inc(ny, 4);
          end;                                              //while
          ny := nSafey + g_Config.nSafeZoneSize;
          if (Envir.GetEvent(nx, ny) = nil) and Envir.CanWalk(nX, nY, false) then
          begin
            SafeZoneLight := TSafeZoneLight.Create(Envir, nX, nY, ET_HOLYCURTAIN, 10 * 24
              * 60 * 60 * 1000, 0);
            g_EventManager.AddEvent(SafeZoneLight);
          end;

          nY := nSafeY - g_Config.nSafeZoneSize;
          nX := nSafeX + g_Config.nSafeZoneSize;
          while ny < nSafey + g_Config.nSafeZoneSize do
          begin

            if (Envir.GetEvent(nx, ny) = nil) and Envir.CanWalk(nX, nY, false) then
            begin
              SafeZoneLight := TSafeZoneLight.Create(Envir, nX, nY, ET_HOLYCURTAIN, 10 *
                24 * 60 * 60 * 1000, 0);
              g_EventManager.AddEvent(SafeZoneLight);
            end;
            inc(ny, 4);
          end;                                              //while

          ny := nSafey + g_Config.nSafeZoneSize;
          if (Envir.GetEvent(nx, ny) = nil) and Envir.CanWalk(nX, nY, false) then
          begin
            SafeZoneLight := TSafeZoneLight.Create(Envir, nX, nY, ET_HOLYCURTAIN, 10 * 24
              * 60 * 60 * 1000, 0);
            g_EventManager.AddEvent(SafeZoneLight);
          end;

        end;                                                //for
      finally
        g_StartPointList.UnLock;
      end;
    end; //if  g_Config.boUseSafeZoneLight
  end;
end;

procedure TUserEngine.ProcessMonsters;
  function GetZenTime(dwTime: LongWord): LongWord;
  var
    d10                                                : Double;
  begin
    if dwTime < 30 * 60 * 1000 then
    begin
      d10 := (GetUserCount - g_Config.nUserFull) / g_Config.nZenFastStep;
      if d10 > 0 then
      begin
        if d10 > 6 then
          d10 := 6;
        Result := dwTime - Round((dwTime / 10) * d10)
      end
      else
      begin                                                 //4B1616
        Result := dwTime;
      end;
    end
    else
    begin
      Result := dwTime;
    end;
    Result := dwTime;
  end;
  //004B1638
var
  dwCurrentTick                                        : LongWord;
  dwRunTick                                            : LongWord;
  dwMonProcTick                                        : LongWord;
  MonGen                                               : pTMonGenInfo;
  nGenCount                                            : Integer;
  nGenModCount                                         : Integer;
  boProcessLimit                                       : Boolean;
  boRegened                                            : Boolean;
  I                                                    : Integer;
  nProcessPosition                                     : Integer;
  Monster                                              : TAnimalObject;
  tCode                                                : Integer;
  tormoncount                                          : integer;
resourcestring
  sExceptionMsg                                          =
    '[Exception] TUserEngine::ProcessMonsters %s %d';
begin
  tCode := 0;
  dwRunTick := GetTickCount();
  try
    tCode := 0;
    boProcessLimit := False;
    dwCurrentTick := GetTickCount();                        // dwCurrentTick
    MonGen := nil;
    //ˢ�¹��￪ʼ

    if ((GetTickCount - dwRegenMonstersTick) > g_Config.dwRegenMonstersTime) then
    begin
      dwRegenMonstersTick := GetTickCount();
      if m_nCurrMonGen < m_MonGenList.Count then
      begin
        MonGen := m_MonGenList.Items[m_nCurrMonGen];
      end;

      if m_nCurrMonGen < m_MonGenList.Count - 1 then
      begin
        Inc(m_nCurrMonGen);
      end
      else
      begin
        m_nCurrMonGen := 0;
      end;                                                  //004B1718

      if (MonGen <> nil) and (MonGen.sMonName <> '') and not g_Config.boVentureServer
        then
      begin
        if (MonGen.dwStartTick = 0) or ((GetTickCount - MonGen.dwStartTick) >
          MonGen.dwZenTime) then
        begin //  GetZenTime(MonGen.dwZenTime))
          nGenCount := GetGenMonCount(MonGen);
          boRegened := True;
          nGenModCount := _MAX(1, ROUND(_MAX(1, MonGen.nCount) / (g_Config.nMonGenRate /
            10)));
          if nGenModCount > nGenCount then
          begin                                             //0806 ���� ����ˢ����������
            tormoncount := nGenModCount - nGenCount;
            boRegened := RegenMonsters(MonGen, tormoncount);  //MonGen,nGenModCount - nGenCount

          end;                                              //004B1798
          if boRegened then
          begin
            MonGen.dwStartTick := GetTickCount();
          end;
        end;                                                //004B17A9
        g_sMonGenInfo1 := MonGen.sMonName + ',' + IntToStr(m_nCurrMonGen) + '/' +
          IntToStr(m_MonGenList.Count);
      end;                                                  //004B1851

    end;                                                    //004B1851

    g_nMonGenTime := GetTickCount - dwCurrentTick;
    if g_nMonGenTime > g_nMonGenTimeMin then
      g_nMonGenTimeMin := g_nMonGenTime;
    if g_nMonGenTime > g_nMonGenTimeMax then
      g_nMonGenTimeMax := g_nMonGenTime;

    //ˢ�¹������

    dwMonProcTick := GetTickCount();
    nMonsterProcessCount := 0;
    tCode := 1;
    //004B187B
    for I := m_nMonGenListPosition to m_MonGenList.Count - 1 do
    begin
      MonGen := m_MonGenList.Items[I];
      tCode := 11;
      if m_nMonGenCertListPosition < MonGen.CertList.Count then
      begin
        nProcessPosition := m_nMonGenCertListPosition;
      end
      else
      begin                                                 //4B18A8
        nProcessPosition := 0;
      end;
      m_nMonGenCertListPosition := 0;
      //4B18B5
      while (True) do
      begin
        if nProcessPosition >= MonGen.CertList.Count then
          break;
        Monster := MonGen.CertList.Items[nProcessPosition];
        tCode := 12;
        if not Monster.m_boGhost then
        begin
          if Integer(dwCurrentTick - Monster.m_dwRunTick) > Monster.m_nRunTime then
          begin                                             // GetTickCount
            Monster.m_dwRunTick := GetTickCount;            //dwRunTick;
            if (dwCurrentTick - Monster.m_dwSearchTick) > Monster.m_dwSearchTime then
            begin                                           //GetTickCount
              Monster.m_dwSearchTick := GetTickCount();
              tCode := 13;
              Monster.SearchViewRange();
            end;
            tCode := 14;

{$IF PROCESSMONSTMODE = OLDMONSTERMODE}
            Monster.Run;
{$ELSE}
            if not Monster.m_boIsVisibleActive and (Monster.m_nProcessRunCount <
              g_Config.nProcessMonsterInterval) then
            begin
              Inc(Monster.m_nProcessRunCount);
            end
            else
            begin
              Monster.m_nProcessRunCount := 0;
              Monster.Run;
            end;
{$IFEND}
            Inc(nMonsterProcessCount);
          end;
          Inc(nMonsterProcessPostion);
        end
        else
        begin //�����ǰ ˢ���б��е� �������ˡ�
          if (GetTickCount - Monster.m_dwGhostTick) > 1 * 60 * 1000 then
          begin
            MonGen.CertList.Delete(nProcessPosition);
            //  MainOutMessage(format('���������ͷ�����:%s/λ��:%d',[Monster.m_sCharName,nProcessPosition]));

            Monster.Free;
            Continue;
          end;
        end;

        Inc(nProcessPosition);
        if (GetTickCount - dwMonProcTick) > g_dwMonLimit then
        begin
          g_sMonGenInfo2 := Monster.m_sCharName + '/' + IntToStr(I) + '/' +
            IntToStr(nProcessPosition);
          boProcessLimit := True;
          m_nMonGenCertListPosition := nProcessPosition;
          break;
        end;
      end;                                                  //while (True) do begin
      if boProcessLimit then
        break;
    end; //for I:= m_nMonGenListPosition to MonGenList.Count -1 do begin
    //004B1A5D

    tCode := 2;
    if m_MonGenList.Count <= I then
    begin
      m_nMonGenListPosition := 0;
      nMonsterCount := nMonsterProcessPostion;
      nMonsterProcessPostion := 0;
      n84 := (n84 + nMonsterProcessCount) div 2;
    end;                                                    //4B1AAF

    if not boProcessLimit then
    begin
      m_nMonGenListPosition := 0;
    end
    else
    begin
      m_nMonGenListPosition := I;
    end;
    g_nMonProcTime := GetTickCount - dwMonProcTick;
    if g_nMonProcTime > g_nMonProcTimeMin then
      g_nMonProcTimeMin := g_nMonProcTime;
    if g_nMonProcTime > g_nMonProcTimeMax then
      g_nMonProcTimeMax := g_nMonProcTime;

  except
    on e: Exception do
    begin
      MainOutMessage(format(sExceptionMsg, [Monster.m_sCharName, tCode]));
      MainOutMessage(E.Message);
      raise;
    end;

  end;
  g_nMonTimeMin := GetTickCount - dwRunTick;
  if g_nMonTimeMax < g_nMonTimeMin then
    g_nMonTimeMax := g_nMonTimeMin;
  asm
      NOP; NOP; NOP; NOP; NOP; NOP; NOP; NOP; NOP; NOP;
  end;
end;

function TUserEngine.GetGenMonCount(MonGen: pTMonGenInfo): Integer; //4AE19C
var
  I                                                    : Integer;
  nCount                                               : Integer;
  BaseObject                                           : TBaseObject;
begin
  nCount := 0;
  for I := 0 to MonGen.CertList.Count - 1 do
  begin
    BaseObject := TBaseObject(MonGen.CertList.Items[I]);
    if not BaseObject.m_boDeath and not BaseObject.m_boGhost then
      Inc(nCount);
  end;
  Result := nCount;
end;

procedure TUserEngine.ProcessNpcs;
var
  dwRunTick, dwCurrTick                                : LongWord;
  i                                                    : integer;
  NPC                                                  : TNormNpc;
  boProcessLimit                                       : Boolean;
begin
  dwRunTick := GetTickCount();
  boProcessLimit := False;
  try
    dwCurrTick := GetTickCount();
    for i := nNpcPosition to QuestNPCList.Count - 1 do
    begin
      NPC := QuestNPCList.Items[i];
      if not NPC.m_boGhost then
      begin
        if Integer(dwCurrTick - NPC.m_dwRunTick) > NPC.m_nRunTime then
        begin
          if (GetTickCount - NPC.m_dwSearchTick) > NPC.m_dwSearchTime then
          begin
            NPC.m_dwSearchTick := GetTickCount();
            NPC.SearchViewRange();
          end;
          if Integer(dwCurrTick - NPC.m_dwRunTick) > NPC.m_nRunTime then
          begin
            NPC.m_dwRunTick := dwCurrTick;
            NPC.Run;                                        {FFFFB}
          end;
        end;
      end
      else
      begin
        if (GetTickCount - NPC.m_dwGhostTick) > 60 * 1000 then
        begin
          NPC.Free;
          QuestNPCList.Delete(i);
          break;
        end;
      end;
      if (GetTickCount - dwRunTick) > g_dwNpcLimit then
      begin
        nNpcPosition := i;
        boProcessLimit := True;
        Break;
      end;
    end;
    if not boProcessLimit then
    begin
      nNpcPosition := 0;
    end;
  except
    MainOutMessage('[Exceptioin] TUserEngine.ProcessNpcs');
  end;
  dwProcessNpcTimeMin := GetTickCount - dwRunTick;
  if dwProcessNpcTimeMin > dwProcessNpcTimeMax then
    dwProcessNpcTimeMax := dwProcessNpcTimeMin;
end;
//004ADE3C

function TUserEngine.RegenMonsterByName(sMap: string; nX, nY: Integer;
  sMonName: string): TBaseObject;
var
  nRace                                                : Integer;
  BaseObject                                           : TBaseObject;
  n18                                                  : Integer;
  MonGen                                               : pTMonGenInfo;
begin
  nRace := GetMonRace(sMonName);

  BaseObject := AddBaseObject(sMap, nX, nY, nRace, sMonName);
  if BaseObject <> nil then
  begin
    n18 := m_MonGenList.Count - 1;
    if n18 < 0 then
      n18 := 0;
    MonGen := m_MonGenList.Items[n18];
    MonGen.CertList.Add(BaseObject);
    BaseObject.m_PEnvir.AddObject(1);
    BaseObject.m_boAddToMaped := True;

  end;

  Result := BaseObject;
end;

function TUserEngine.RegenMonsterysByName(sMonName: string; human: Tplayobject):
  TBaseObject;
var

  BaseObject                                           : TBaseObject;
  n18                                                  : Integer;
  MonGen                                               : pTMonGenInfo;
begin
  //  nRace:=GetMonRace(sMonName);
  BaseObject := makenewplay(sMonName, human); //AddBaseObject(sMap,nX,nY,nRace,sMonName);
  //   BaseObject:=TMonsterys.Create;
  if BaseObject <> nil then
  begin
    n18 := m_MonGenList.Count - 1;
    if n18 < 0 then
      n18 := 0;
    MonGen := m_MonGenList.Items[n18];
    MonGen.CertList.Add(BaseObject);
    BaseObject.m_PEnvir.AddObject(1);
    BaseObject.m_boAddToMaped := True;

    //  baseobject.m_boMission:=false;              //hint
 //    MainOutMessage(format('MonGet Count:%d',[MonGen.CertList.Count]));
  end;

  Result := BaseObject;
end;

procedure TUserEngine.Run;                                  //004B20B8
//var
//  i:integer;
//  dwProcessTick:LongWord;
resourcestring
  sExceptionMsg                                        = '[Exception] TUserEngine::Run';
begin
  CalceTime := GetTickCount;
  try
    if (GetTickCount() - dwShowOnlineTick) > g_Config.dwConsoleShowUserCountTime then
    begin
      //      if (GetTickCount() - dwShowOnlineTime) > 5000 then begin
      dwShowOnlineTick := GetTickCount();
      NoticeManager.LoadingNotice;
      //        MainOutMessage(TimeToStr(Now) + ' ������: ' + IntToStr(GetUserCount));
      MainOutMessage('������: ' + IntToStr(GetUserCount));
      //        UserCastle.Save;
      g_CastleManager.Save;
    end;
    if (GetTickCount() - dwSendOnlineHumTime) > 10000 then
    begin
      dwSendOnlineHumTime := GetTickCount();
      FrmIDSoc.SendOnlineHumCountMsg(GetOnlineHumCount);
      //        GuildManager.Run;
      //        UserCastle.Run;
      //        for i:=0 to DenySayMsgList.Count - 1 do begin
      //          //
      //        end;
    end;
  except
    on e: Exception do
    begin
      MainOutMessage(sExceptionMsg);
      MainOutMessage(E.Message);
      raise;
    end;

  end;
  //    dwUsrTimeMin:=GetTickCount() - CalceTime;
  //    if dwUsrTimeMax < dwUsrTimeMin then dwUsrTimeMax:=dwUsrTimeMin;

end;

function TUserEngine.GetStdItem(nItemIdx: Integer): pTStdItem; //004AC2F8
begin
  Result := nil;
  Dec(nItemIdx);
  if (nItemIdx >= 0) and (StdItemList.Count > nItemIdx) then
  begin
    Result := StdItemList.Items[nItemIdx];

    if Result.Name = '' then
      Result := nil;
  end;
end;

function TUserEngine.GetStdItem(nStdMode, nShape: Integer): PTStdItem; //004AC348
var
  I                                                    : Integer;
  StdItem                                              : pTStdItem;
begin
  Result := nil;
  for I := 0 to StdItemList.Count - 1 do
  begin
    StdItem := StdItemList.Items[i];
    if (stditem.Shape = nShape) and (StdItem.StdMode = nStdMode) then
    begin
      Result := StdItem;
      break;
    end;
  end;
end;

function TUserEngine.GetStdItem(sItemName: string): PTStdItem; //004AC348
var
  I                                                    : Integer;
  StdItem                                              : pTStdItem;
begin
  Result := nil;
  if sItemName = '' then
    exit;
  for I := 0 to StdItemList.Count - 1 do
  begin
    StdItem := StdItemList.Items[i];
    if CompareText(StdItem.Name, sItemName) = 0 then
    begin
      Result := StdItem;
      break;
    end;
  end;
end;

function TUserEngine.GetStdItemWeight(nItemIdx: Integer): Integer; //004AC2B0
var
  StdItem                                              : pTStdItem;
begin
  Dec(nItemIdx);
  if (nItemIdx >= 0) and (StdItemList.Count > nItemIdx) then
  begin
    StdItem := StdItemList.Items[nItemIdx];
    Result := StdItem.Weight;
  end
  else
  begin
    Result := 0;
  end;
end;

function TUserEngine.GetStdItemName(nItemIdx: Integer; boFilter: Boolean = True): string;  //004AC1AC
begin
  Result := '';
  Dec(nItemIdx);
  if (nItemIdx >= 0) and (StdItemList.Count > nItemIdx) then
  begin
    Result := pTStdItem(StdItemList.Items[nItemIdx]).Name;
  end
  else
    Result := '';
  if boFilter then
    Result := FilterItemName(Result);
end;

function TUserEngine.FindOtherServerUser(sName: string;
  var nServerIndex): Boolean;
begin
  Result := False;
end;

//004AEA00

procedure TUserEngine.CryCry(wIdent: Word; pMap: TEnvirnoment; nX, nY,
  nWide: Integer; btFColor, btBColor: Byte; sMsg: string);
var
  i                                                    : integer;
  PlayObject                                           : TPlayObject;
begin
  for I := 0 to m_PlayObjectList.Count - 1 do
  begin
    PlayObject := TPlayObject(m_PlayObjectList.Objects[i]);
    if not PlayObject.m_boGhost and
      (PlayObject.m_PEnvir = pMap) and
      (PlayObject.m_boBanShout) and
      (abs(PlayObject.m_nCurrX - nX) < nWide) and
      (abs(PlayObject.m_nCurrY - nY) < nWide) then
    begin
      if PlayObject.sYsnameMaster = '' then                 // �������Ԫ��
        //PlayObject.SendMsg(nil,wIdent,0,0,$FFFF,0,sMsg);
        PlayObject.SendMsg(nil, wIdent, 0, btFColor, btBColor, 0, sMsg);
    end;
  end;
end;

procedure TUserEngine.DemoRun;
begin
  Run();
end;

function TUserEngine.MonGetRandomItems(mon: TBaseObject): Integer; //004AD2E8
var
  i                                                    : integer;
  ItemList                                             : TList;
  iname                                                : string;
  MonItem                                              : pTMonItemInfo;
  UserItem                                             : pTUserItem;
  StdItem                                              : pTStdItem;
  Monster                                              : pTMonInfo;
begin
  ItemList := nil;
  for i := 0 to MonsterList.Count - 1 do
  begin
    Monster := MonsterList.Items[i];
    if CompareText(Monster.sName, mon.m_sCharName) = 0 then
    begin
      ItemList := Monster.Itemlist;
      break;
    end;
  end;
  if ItemList <> nil then
  begin
    for i := 0 to ItemList.Count - 1 do
    begin
      MonItem := pTMonItemInfo(ItemList[i]);
      if Random(MonItem.MaxPoint) <= MonItem.SelPoint then
      begin
        if CompareText(MonItem.ItemName, sSTRING_GOLDNAME) = 0 then
        begin
          mon.m_nGold := mon.m_nGold + (MonItem.Count div 2) + Random(MonItem.Count);
        end
        else
        begin
          //����ũ ������ �̺�Ʈ....
          iname := '';
          ////if (BoUniqueItemEvent) and (not mon.BoAnimal) then begin
          ////   if GetUniqueEvnetItemName (iname, numb) then begin
                //numb; //iname
          ////   end;
          ////end;
          if iname = '' then
            iname := MonItem.ItemName;

          New(UserItem);
          if CopyToUserItemFromName(iname, UserItem) then
          begin
            UserItem.Dura := Round((UserItem.DuraMax / 100) * (20 + Random(80)));

            StdItem := GetStdItem(UserItem.wIndex);
            ////if pstd <> nil then
            ////   if pstd.StdMode = 50 then begin  //��ǰ��
            ////      pu.Dura := numb;
            ////   end;
            if Random(g_Config.nMonRandomAddValue {10}) = 0 then
              RandomUpgradeItem(UserItem);
            if StdItem.StdMode in [15, 19, 20, 21, 22, 23, 24, 26] then
            begin
              if (StdItem.Shape = 130) or (StdItem.Shape = 131) or (StdItem.Shape = 132)
                then
              begin
                GetUnknowItemValue(UserItem);
              end;
            end;
            mon.m_ItemList.Add(UserItem)
          end
          else
            Dispose(UserItem);
        end;
      end;
    end;
  end;
  Result := 1;
end;

procedure TUserEngine.RandomUpgradeItem(Item: PTUserItem);  //004AD0C8
var
  StdItem                                              : pTStdItem;
begin
  StdItem := GetStdItem(Item.wIndex);
  if StdItem = nil then
    exit;
  case StdItem.StdMode of
    5, 6: ItemUnit.RandomUpgradeWeapon(Item);               //004AD14A
    10, 11: ItemUnit.RandomUpgradeDress(Item);
    19: ItemUnit.RandomUpgrade19(Item);
    20, 21, 24: ItemUnit.RandomUpgrade202124(Item);
    26: ItemUnit.RandomUpgrade26(Item);
    22: ItemUnit.RandomUpgrade22(Item);
    23: ItemUnit.RandomUpgrade23(Item);
    15: ItemUnit.RandomUpgradeHelMet(Item);
  end;
end;

procedure TUserEngine.GetUnknowItemValue(Item: PTUserItem); //004AD1D4
var
  StdItem                                              : pTStdItem;
begin
  StdItem := GetStdItem(Item.wIndex);
  if StdItem = nil then
    exit;
  case StdItem.StdMode of
    15: ItemUnit.UnknowHelmet(Item);
    22, 23: ItemUnit.UnknowRing(Item);
    24, 26: ItemUnit.UnknowNecklace(Item);
  end;
end;

//004AC404

function TUserEngine.CopyToUserItemFromName(sItemName: string; Item: pTUserItem):
  Boolean;
var
  I                                                    : Integer;
  StdItem                                              : pTStdItem;
begin
  Result := False;
  if sItemName <> '' then
  begin
    for I := 0 to StdItemList.Count - 1 do
    begin
      StdItem := StdItemList.Items[i];
      if CompareText(StdItem.Name, sItemName) = 0 then
      begin
        FillChar(Item^, SizeOf(TUserItem), #0);
        Item.wIndex := i + 1;
        Item.MakeIndex := GetItemNumber();
        Item.Dura := StdItem.DuraMax;
        Item.DuraMax := StdItem.DuraMax;
        Result := True;
        break;
      end;
    end;
  end;
end;

procedure TUserEngine.ProcessUserMessage(PlayObject: TPlayObject; DefMsg:
  pTDefaultMessage; Buff: PChar);                             //004B232C
var
  sMsg                                                 : string;
resourcestring
  sExceptionMsg                                          =
    '[Exception] TUserEngine::ProcessUserMessage..';
begin
  if (DefMsg = nil) then
    exit;
  if (PlayObject <> nil) and (PlayObject.m_boDeath or PlayObject.m_boGhost) and
    (DefMsg.Ident <> CM_SOFTCLOSE) then
  begin
    //  MainOutMessage(inttostr(Defmsg.Ident));
    exit;                                                   //���������ܿͻ�������
  end;
  try
    if Buff = nil then
      sMsg := ''
    else
      sMsg := StrPas(Buff);
    // MainOutMessage(inttostr(Defmsg.Ident));
    case DefMsg.Ident of
      CM_SPELL:
        begin                                               //3017
          // if PlayObject.GetSpellMsgCount <=2 then  //����������г�������ħ���������򲻼������
          if g_Config.boSpellSendUpdateMsg then
          begin //ʹ��UpdateMsg ���Է�ֹ��Ϣ�������ж������
            PlayObject.SendUpdateMsg(PlayObject,
              DefMsg.Ident,
              DefMsg.Tag,
              LoWord(DefMsg.Recog),
              HiWord(DefMsg.Recog),
              MakeLong(DefMsg.Param,
              DefMsg.Series),
              '');
          end
          else
          begin
            PlayObject.SendMsg(PlayObject,
              DefMsg.Ident,
              DefMsg.Tag,
              LoWord(DefMsg.Recog),
              HiWord(DefMsg.Recog),
              MakeLong(DefMsg.Param,
              DefMsg.Series),
              '');
          end;
        end;

      CM_QUERYUSERNAME:
        begin                                               //80
          PlayObject.SendMsg(PlayObject, DefMsg.Ident, 0, DefMsg.Recog, DefMsg.Param {x},
            DefMsg.Tag {y}, '');
        end;

      CM_DROPITEM,
        CM_TAKEONITEM,
        CM_TAKEOFFITEM,
        CM_1005,

      CM_MERCHANTDLGSELECT,
        CM_MERCHANTQUERYSELLPRICE,
        CM_USERSELLITEM,
        CM_USERBUYITEM,
        CM_USERGETDETAILITEM,

      CM_CREATEGROUP,
        CM_ADDGROUPMEMBER,
        CM_DELGROUPMEMBER,
        CM_USERREPAIRITEM,
        CM_MERCHANTQUERYREPAIRCOST,
        CM_DEALTRY,
        CM_DEALADDITEM,
        CM_DEALDELITEM,

      CM_USERSTORAGEITEM,
        CM_USERTAKEBACKSTORAGEITEM,
        //      CM_WANTMINIMAP,
      CM_USERMAKEDRUGITEM,

      //      CM_GUILDHOME,
      CM_GUILDADDMEMBER,
        CM_GUILDDELMEMBER,
        CM_GUILDUPDATENOTICE,
        CM_GUILDUPDATERANKINFO:
        begin
          PlayObject.SendMsg(PlayObject,
            DefMsg.Ident,
            DefMsg.Series,
            DefMsg.Recog,
            DefMsg.Param,
            DefMsg.Tag,
            DecodeString(sMsg));
        end;
      CM_PASSWORD,
        CM_CHGPASSWORD,
        CM_SETPASSWORD:
        begin
          PlayObject.SendMsg(PlayObject,
            DefMsg.Ident,
            DefMsg.Param,
            DefMsg.Recog,
            DefMsg.Series,
            DefMsg.Tag,
            DecodeString(sMsg));
        end;
      CM_ADJUST_BONUS:
        begin                                               //1043
          PlayObject.SendMsg(PlayObject,
            DefMsg.Ident,
            DefMsg.Series,
            DefMsg.Recog,
            DefMsg.Param,
            DefMsg.Tag,
            sMsg);
        end;
      CM_HORSERUN,
        CM_TURN,
        CM_WALK,
        CM_SITDOWN,
        CM_RUN,
        CM_HIT,
        CM_HEAVYHIT,
        CM_BIGHIT,
        CM_3026HIT,
        CM_POWERHIT,
        CM_LONGHIT,
        CM_CRSHIT,
        //      CM_TWNHIT,
      CM_WIDEHIT,
        CM_FIREHIT:
        begin
          //if (PlayObject.m_boBaoZiAttacked) and (DefMsg.Ident=CM_RUN) then
          //   DefMsg.Ident:=CM_HORSERUN;
          if g_Config.boActionSendActionMsg then
          begin //ʹ��UpdateMsg ���Է�ֹ��Ϣ�������ж������
            PlayObject.SendActionMsg(PlayObject,
              DefMsg.Ident,
              DefMsg.Tag,
              LoWord(DefMsg.Recog),                         {x}
              HiWord(DefMsg.Recog),                         {y}
              DefMsg.Series,
              '');
          end
          else
          begin
            PlayObject.SendMsg(PlayObject,
              DefMsg.Ident,
              DefMsg.Tag,
              LoWord(DefMsg.Recog),                         {x}
              HiWord(DefMsg.Recog),                         {y}
              DefMsg.Series,
              '');
          end;
        end;
      CM_SAY:
        begin
          PlayObject.SendMsg(PlayObject, CM_SAY, 0, 0, 0, 0, DecodeString(sMsg));
        end;
    else
      begin
        PlayObject.SendMsg(PlayObject,
          DefMsg.Ident,
          DefMsg.Series,
          DefMsg.Recog,
          DefMsg.Param,
          DefMsg.Tag,
          sMsg);
      end;
    end;
    if PlayObject.m_boReadyRun then
    begin
      case DefMsg.Ident of
        CM_TURN, CM_WALK, CM_SITDOWN, CM_RUN, CM_HIT, CM_HEAVYHIT, CM_BIGHIT,
          CM_POWERHIT, CM_LONGHIT,
          CM_WIDEHIT, CM_FIREHIT, CM_CRSHIT, CM_TWNHIT:
          begin
            Dec(PlayObject.m_dwRunTick, 100);
          end;
      end;
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
end;
//004AF728

procedure TUserEngine.SendServerGroupMsg(nCode, nServerIdx: Integer;
  sMsg: string);
begin
  if nServerIndex = 0 then
  begin
    FrmSrvMsg.SendSocketMsg(IntToStr(nCode) + '/' + EncodeString(IntToStr(nServerIdx)) +
      '/' + EncodeString(sMsg));
  end
  else
  begin
    FrmMsgClient.SendSocket(IntToStr(nCode) + '/' + EncodeString(IntToStr(nServerIdx)) +
      '/' + EncodeString(sMsg));
  end;
end;

function TUserEngine.AddBaseObject(sMapName: string; nX, nY: Integer; nMonRace: Integer;
  sMonName: string): TBaseObject;                             //004AD56C
var
  Map                                                  : TEnvirnoment;
  Cert                                                 : TBaseObject;
  n1C, n20, n24                                        : Integer;
  p28                                                  : Pointer;
begin
  Result := nil;
  Cert := nil;

  Map := g_MapManager.FindMap(sMapName);
  if Map = nil then
    exit;
  case nMonRace of
    2: cert := TMonsteys.Create;
    11: Cert := TSuperGuard.Create;                         //��ʿ
    13:
      begin
        Cert := TSuperGuard.Create;
        TSuperGuard(Cert).botianyu := true;
      end;
    20: Cert := TArcherPolice.Create;
    50:
      begin                                                 //���ֱ�
        Cert := TMonster1.Create;
        Cert.m_boAnimal := True;
        Cert.m_nMeatQuality := Random(3500) + 3000;
        Cert.m_nBodyLeathery := 150;
        Cert.m_boNoAttackMode := true;
        TMonster1(Cert).m_canpickup := true;
        Cert.m_boAdminMode := true;                         //���ﲻ����
      end;
    51:
      begin
        Cert := TMonster.Create;
        Cert.m_boAnimal := True;
        Cert.m_nMeatQuality := Random(3500) + 3000;
        Cert.m_nBodyLeathery := 50;
      end;
    52:
      begin
        if Random(30) = 0 then
        begin
          Cert := TChickenDeer.Create;
          Cert.m_boAnimal := True;
          Cert.m_nMeatQuality := Random(20000) + 10000;
          Cert.m_nBodyLeathery := 150;
        end
        else
        begin
          Cert := TMonster.Create;
          Cert.m_boAnimal := True;
          Cert.m_nMeatQuality := Random(8000) + 8000;
          Cert.m_nBodyLeathery := 150;
        end;
      end;

    53:
      begin
        Cert := TATMonster.Create;
        Cert.m_boAnimal := True;
        Cert.m_nMeatQuality := Random(8000) + 8000;
        Cert.m_nBodyLeathery := 150;
      end;
    55:
      begin
        Cert := TTrainer.Create;
        Cert.m_btRaceServer := 55;
      end;
    80: Cert := TMonster.Create;
    81: Cert := TATMonster.Create;
    82: Cert := TSpitSpider.Create;
    83: Cert := TSlowATMonster.Create;
    84: Cert := TScorpion.Create;
    85: Cert := TStickMonster.Create;
    86: Cert := TATMonster.Create;
    87: Cert := TDualAxeMonster.Create;                     //Ͷì
    88: Cert := TATMonster.Create;
    89: Cert := TATMonster.Create;
    90: Cert := TGasAttackMonster.Create;
    91: Cert := TMagCowMonster.Create;
    92: Cert := TCowKingMonster.Create;                     //����������
    93: Cert := TThornDarkMonster.Create;
    94: Cert := TLightingZombi.Create;
    95:
      begin
        Cert := TDigOutZombi.Create;
        if Random(2) = 0 then
          Cert.bo2BA := True;
      end;
    96:
      begin
        Cert := TZilKinZombi.Create;
        if Random(4) = 0 then
          Cert.bo2BA := True;
      end;
    97:
      begin
        Cert := TCowMonster.Create;
        if Random(2) = 0 then
          Cert.bo2BA := True;
      end;
    99:
      begin
        Cert := TNIMOKEMonster.Create;                      //��ħ���� �Ŀ�
        TNIMOKEMonster(Cert).pm_wAppr := 87;
      end;
    100: Cert := TWhiteSkeleton.Create;
    101:
      begin
        Cert := TScultureMonster.Create;
        Cert.bo2BA := True;
      end;
    102: Cert := TScultureKingMonster.Create;
    103: Cert := TBeeQueen.Create;
    104: Cert := TArcherMonster.Create;
    105: Cert := TGasMothMonster.Create;                    //Ш��
    106: Cert := TGasDungMonster.Create;
    107: Cert := TCentipedeKingMonster.Create;
    110, 3: Cert := TCastleDoor.Create;
    111: Cert := TWallStructure.Create;
    112: Cert := TArcherGuard.Create;                       //������
    113: Cert := TElfMonster.Create;
    114: Cert := TElfWarriorMonster.Create;
    115: Cert := TBigHeartMonster.Create;                   // TDualAxeMonster
    116: Cert := TSpiderHouseMonster.Create;
    117: Cert := TExplosionSpider.Create;
    118: Cert := THighRiskSpider.Create;
    119: Cert := TBigPoisionSpider.Create;
    120: Cert := TSoccerBall.Create;

    122:
      begin
        Cert := TNIMOKEMonster.Create;                      //  //��ħ��ʿ
        TNIMOKEMonster(Cert).pm_wAppr := 87;
      end;
    123:
      begin
        Cert := TNIMOKEMonster.Create;                      // //��ħ����
        TNIMOKEMonster(Cert).pm_wAppr := 86;
      end;
    124:
      begin
        Cert := TNIMOAXEMonster.Create;                     //��ħ������
        TNIMOAXEMonster(Cert).pm_wAppr := 85;
      end;
    125:
      begin
        Cert := TNIMOKEMonster.Create;                      //  //��ħ����
        TNIMOKEMonster(Cert).pm_wAppr := 128;
      end;
    126, 108:
      begin
        Cert := TScultureKingMonster.Create;                //��ħ
        TScultureKingMonster(Cert).pm_wAppr := 88;
        //  TMonster(Cert).m_btusefire:= 5
      end;

    200: Cert := TElectronicScolpionMon.Create;
    201, 129: Cert := Ttiexueking.Create;                   //��Ѫħ��
    16:
      begin
        Cert := Taiman.Create;
        Cert.m_boAdminMode := true;
        //   Cert.m_boNoAttackMode:=true;
      end;
    17:
      begin
        Cert := Ttymon.Create;
      end;

    202:
      begin //�߶���ȫ��Ļ����   ͨ���������
        Cert := Tbigheatmovemonster.Create;
      end;
    203: Cert := Tbigheatmonsteraxe.Create;                 // Ͷʯ��ħ ȫ��Ļ���� +���
    204: Cert := TSeeBeeQueen.Create;                       //���ĺ���
    205: Cert := TAXEHIDEMonster.Create;                    //ħ��
    206:
      begin
        Cert := TWhiteSkeleton.Create;
        TMonster(Cert).m_btUsePoison := POISON_DECHEALTH;
      end;
    207:                                                    //�ػ����ｫ
      begin
        Cert := TfireMonster.Create;
        TMonster1(Cert).m_btusefire := 5                    //��ǽЧ��
      end;
    208:
      begin
        Cert := TCowKingMonster.Create;
        TMonster(Cert).m_btUsePoison := POISON_STONE;
      end;
    209:
      begin
        Cert := Tkilltymon.Create;
        Cert.m_btRaceServer := 209;
      end;
    210:
      begin
        Cert := Ttiaopi.Create;
      end;
    211:
      begin
        Cert := Tmontishen.Create;

      end;
    254, 255, 253:
      begin
        cERT := TEvilMonster.Create;
      end;
    12:
      begin
        Cert := TMonster12.Create;
      end;
    21, 14: Cert := TMonster21.Create;
  end;

  if Cert <> nil then
  begin
    MonInitialize(Cert, sMonName);
    Cert.m_PEnvir := Map;
    Cert.m_sMapName := sMapName;
    Cert.m_nCurrX := nX;
    Cert.m_nCurrY := nY;
    Cert.m_btDirection := Random(8);
    Cert.m_sCharName := sMonName;
    Cert.m_WAbil := Cert.m_Abil;
    if Random(100) < Cert.m_btCoolEye then
      Cert.m_boCoolEye := True;
    MonGetRandomItems(Cert);                                //ȡ�ù��ﱬ��Ʒ����
    Cert.Initialize();                                      //004ADC97 $0FFFE
    if Cert.m_boAddtoMapSuccess then
    begin
      p28 := nil;
      if Cert.m_PEnvir.m_nWidth < 50 then
        n20 := 2
      else
        n20 := 3;
      if (Cert.m_PEnvir.m_nHeight < 250) then
      begin
        if (Cert.m_PEnvir.m_nHeight < 30) then
          n24 := 2
        else
          n24 := 20;
      end
      else
        n24 := 50;

      n1C := 0;
      while (True) do
      begin
        if not Cert.m_PEnvir.CanWalk(Cert.m_nCurrX, Cert.m_nCurrY, False) then
        begin
          if (Cert.m_PEnvir.m_nWidth - n24 - 1) > Cert.m_nCurrX then
          begin
            Inc(Cert.m_nCurrX, n20);
          end
          else
          begin                                             //004ADD9D
            Cert.m_nCurrX := Random(Cert.m_PEnvir.m_nWidth div 2) + n24;
            if Cert.m_PEnvir.m_nHeight - n24 - 1 > Cert.m_nCurrY then
            begin
              Inc(Cert.m_nCurrY, n20);
            end
            else
            begin                                           //004ADDBE
              Cert.m_nCurrY := Random(Cert.m_PEnvir.m_nHeight div 2) + n24;
            end;
          end;
        end
        else
        begin                                               //004ADDC0
          p28 := Cert.m_PEnvir.AddToMap(Cert.m_nCurrX, Cert.m_nCurrY, OS_MOVINGOBJECT,
            Cert);
          break;
        end;
        Inc(n1C);
        if n1C >= 31 then
          break;
      end;

      if p28 = nil then
      begin
        Cert.Free;
        Cert := nil;
      end;
    end;
  end;

  Result := Cert;
end;

function TUserEngine.makenewplay(s_name: string; human: Tplayobject): TBaseObject;
var
  PlayObject                                           : TBASEOBJECT;

  Envir                                                : TEnvirnoment;
  nC                                                   : integer;
  p28                                                  : Pointer;
resourcestring
  sExceptionMsg                                          =
    '[Exception] TUserEngine::MakePlay';
label
  ReGetMap;
begin
  Result := nil;
  p28 := nil;
  try
    PlayObject := TMonsteys.Create;
    //     PlayObject.m_btRaceServer:= RC_PLAYOBJECT;

    CopyHumData(playobject, human);

    PlayObject.m_sCharName := s_name;

    Envir := human.m_PEnvir;
    PlayObject.m_PEnvir := Envir;
    PlayObject.m_nCurrX := PlayObject.m_nCurrX - 3 + Random(6);
    PlayObject.m_nCurrY := PlayObject.m_nCurry - 3 + Random(6);

    while (True) do
    begin                                                   //004B03CC
      if Envir.CanWalk(PlayObject.m_nCurrX, PlayObject.m_nCurrY, True) then
      begin
        PlayObject.m_PEnvir := Envir;
        p28 := PlayObject.m_PEnvir.AddToMap(PlayObject.m_nCurrX, PlayObject.m_nCurrY,
          OS_MOVINGOBJECT, PlayObject);
        break;
      end;
      PlayObject.m_nCurrX := PlayObject.m_nCurrX - 3 + Random(6);
      PlayObject.m_nCurrY := PlayObject.m_nCurry - 3 + Random(6);
      Inc(nC);
      if nC >= 5 then
        break;
    end;
    if p28 = nil then
    begin
      PlayObject.Free;
      PlayObject := nil;
    end;

    //       PlayObject.m_boReadyRun:=false;

    Result := PlayObject;

  except
    MainOutMessage(sExceptionMsg);
  end;
end;

//====================================================
//����:�����������
//����ֵ����ָ��ʱ���ڴ���������򷵼�TRUE���������ָ��ʱ���򷵻�FALSE
//====================================================

function TUserEngine.RegenMonsters(MonGen: pTMonGenInfo; nCount: integer): Boolean;  //004ADF04
var
  dwStartTick                                          : LongWord;

  nX                                                   : Integer;
  nY                                                   : Integer;
  i                                                    : Integer;
  Cert                                                 : TBaseObject;
resourcestring
  sExceptionMsg                                          =
    '[Exception] TUserEngine::RegenMonsters';
begin
  Result := True;
  dwStartTick := GetTickCount();
  try
    if MonGen.nRace > 0 then
    begin
      if Random(100) < MonGen.nMissionGenRate then
      begin
        nX := (MonGen.nX - MonGen.nRange) + Random(MonGen.nRange * 2 + 1);
        nY := (MonGen.nY - MonGen.nRange) + Random(MonGen.nRange * 2 + 1);
        for i := 0 to nCount - 1 do
        begin
          Cert := AddBaseObject(MonGen.sMapName, ((nX - 10) + Random(20)), ((nY - 10) +
            Random(20)), MonGen.nRace, MonGen.sMonName);
          if Cert <> nil then
          begin
            MonGen.CertList.Add(Cert);

          end;
          if ((GetTickCount - dwStartTick) > g_dwZenLimit) and (i < nCount - 1) then
          begin                                             //ˢ��ʱ�����
            Result := False;
            Break;
          end;
        end;                                                //4AE058
      end
      else
      begin                                                 //004AE063
        for i := 0 to nCount - 1 do
        begin
          nX := (MonGen.nX - MonGen.nRange) + Random(MonGen.nRange * 2 + 1);
          nY := (MonGen.nY - MonGen.nRange) + Random(MonGen.nRange * 2 + 1);
          Cert := AddBaseObject(MonGen.sMapName, nX, nY, MonGen.nRace, MonGen.sMonName);
          if Cert <> nil then
            MonGen.CertList.Add(Cert);
          if ((GetTickCount - dwStartTick) > g_dwZenLimit) and (i < nCount - 1) then
          begin
            Result := False;
            break;
          end;
        end;
      end;
      if Cert <> nil then
      begin
        if Mongen.sMonNewName <> '' then
        begin
          Cert.m_nNewLevel := Mongen.nLevel;

          Cert.m_sNewName := IntToStr(Mongen.nLevel) + '��' + Mongen.sMonNewName;
        end;
      end;
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

procedure TUserEngine.WriteShiftUserData();
//004AF510
begin

end;

function TUserEngine.GetPlayObject(sName: string): TPlayObject; //004AE640
var
  i                                                    : Integer;
  PlayObject                                           : TPlayObject;
begin
  Result := nil;
  for i := m_PlayObjectList.Count - 1 downto 0 do
  begin
    if CompareText(m_PlayObjectList.Strings[i], sName) = 0 then
    begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[i]);
      if PlayObject = nil then Continue;
      if not PlayObject.m_boGhost then
      begin
        if not (PlayObject.m_boPasswordLocked and PlayObject.m_boObMode and
          PlayObject.m_boAdminMode) then
          Result := PlayObject;
      end;
      Break;
    end;
  end;
end;

procedure TUserEngine.KickPlayObjectEx(sName: string);
var
  i                                                    : Integer;
  PlayObject                                           : TPlayObject;
begin
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    for i := 0 to m_PlayObjectList.Count - 1 do
    begin
      if CompareText(m_PlayObjectList.Strings[i], sName) = 0 then
      begin
        PlayObject := TPlayObject(m_PlayObjectList.Objects[i]);
        PlayObject.m_boEmergencyClose := True;
        Break;
      end;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

function TUserEngine.GetPlayObjectEx(sName: string): TPlayObject; //004AE640
var
  I                                                    : Integer;
begin
  Result := nil;
  if sName = '' then
    exit;
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    for I := 0 to m_PlayObjectList.Count - 1 do
    begin
      if CompareText(m_PlayObjectList.Strings[I], sName) = 0 then
      begin
        Result := TPlayObject(m_PlayObjectList.Objects[I]);
        Break;
      end;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

function TUserEngine.GetPlayObjectExOfAutoGetExp(sAccount: string): TPlayObject;
var
  I                                                    : Integer;
  PlayObject                                           : TPlayObject;
begin
  Result := nil;
  EnterCriticalSection(ProcessHumanCriticalSection);
  try
    for I := 0 to m_PlayObjectList.Count - 1 do
    begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
      if PlayObject <> nil then
      begin
        if (CompareText(PlayObject.m_sUserID, sAccount) = 0) and PlayObject.m_booffline
          then
        begin
          Result := PlayObject;
          Break;
        end;
      end;
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

function TUserEngine.FindMerchant(nFlag: Integer): TMerchant; //004AC858
var
  I                                                    : Integer;
begin
  Result := nil;
  m_MerchantList.Lock;
  try
    for I := 0 to m_MerchantList.Count - 1 do
    begin
      if TMerchant(m_MerchantList.Items[i]).m_nCastle - 1 = nFlag then
      begin
        Result := TMerchant(m_MerchantList.Items[i]);
        break;
      end;
    end;
  finally
    m_MerchantList.UnLock;
  end;
end;

function TUserEngine.FindMerchant(x, y: Integer; sMapName: string): TMerchant;
var
  I                                                    : Integer;
  Merchant                                             : TMerchant;
begin
  Result := nil;
  m_MerchantList.Lock;
  try
    for I := 0 to m_MerchantList.Count - 1 do
    begin
      Merchant := TMerchant(m_MerchantList.Items[i]);
      if (Merchant.m_PEnvir.sMapName = sMapName) and (Merchant.m_nCurrX = x) and
        (Merchant.m_nCurrY = Y) then
      begin
        Result := Merchant;
        break;
      end;
    end;
  finally
    m_MerchantList.UnLock;
  end;
end;

function TUserEngine.FindMerchant(Merchant: TObject): TMerchant; //004AC858
var
  I                                                    : Integer;
begin
  Result := nil;
  m_MerchantList.Lock;
  try
    for I := 0 to m_MerchantList.Count - 1 do
    begin
      if TObject(m_MerchantList.Items[i]) = Merchant then
      begin
        Result := TMerchant(m_MerchantList.Items[i]);
        break;
      end;
    end;
  finally
    m_MerchantList.UnLock;
  end;
end;

function TUserEngine.FindMon(Mon: TObject): TBaseObject;

begin
  result := nil;
end;

function TUserEngine.FindNPC(GuildOfficial: TObject): TGuildOfficial; //004ACB24
var
  I                                                    : Integer;
begin
  Result := nil;
  for I := 0 to QuestNPCList.Count - 1 do
  begin
    if TObject(QuestNPCList.Items[i]) = GuildOfficial then
    begin
      Result := TGuildOfficial(QuestNPCList.Items[i]);
      break;
    end;
  end;
end;

//4AE810

function TUserEngine.GetMapOfRangeHumanCount(Envir: TEnvirnoment; nX, nY,
  nRange: integer): Integer;
var
  I                                                    : Integer;
  PlayObject                                           : TPlayObject;
begin
  Result := 0;
  for I := 0 to m_PlayObjectList.Count - 1 do
  begin
    PlayObject := TPlayObject(m_PlayObjectList.Objects[i]);
    if not PlayObject.m_boGhost and (PlayObject.m_PEnvir = Envir) then
    begin
      if (abs(PlayObject.m_nCurrX - nX) < nRange) and (abs(PlayObject.m_nCurrY - nY) <
        nRange) then
        Inc(Result);
    end;
  end;
end;

function TUserEngine.GetHumPermission(sUserName: string; var sIPaddr: string; var
  btPermission: Byte): Boolean;                               //4AE590
var
  I                                                    : Integer;
  AdminInfo                                            : pTAdminInfo;
begin
  Result := False;
  btPermission := g_Config.nStartPermission;
  m_AdminList.Lock;
  try
    for I := 0 to m_AdminList.Count - 1 do
    begin
      AdminInfo := m_AdminList.Items[I];
      if CompareText(AdminInfo.sChrName, sUserName) = 0 then
      begin
        btPermission := AdminInfo.nLv;
        sIPaddr := AdminInfo.sIPaddr;
        Result := True;
        break;
      end;
    end;
  finally
    m_AdminList.UnLock;
  end;
end;

function TUserEngine.GetItemAnicount(sItemName: string): Integer;
var
  nItemIdx                                             : Integer;
begin
  Result := 0;
  nItemIdx := GetStdItemIdx(sItemName) - 1;
  if nItemIdx < 0 then Exit;
  if nItemIdx < Length(StdItemofAnnicount) then
    Result := StdItemofAnnicount[nItemIdx];
end;

function TUserEngine.GetItemAnicount(nItemIdx: Integer): Integer;
begin
  Result := 0;
  Dec(nItemidx);
  if nItemIdx < 0 then Exit;
  if nItemIdx < Length(StdItemofAnnicount) then
    Result := StdItemofAnnicount[nItemIdx];
end;

procedure TUserEngine.GenShiftUserData;
//004AEF6C
begin

end;

//004AE3FC

procedure TUserEngine.AddUserOpenInfo(UserOpenInfo: pTUserOpenInfo);
begin
  EnterCriticalSection(m_LoadPlaySection);
  try
    m_LoadPlayList.AddObject(UserOpenInfo.sChrName, Tobject(UserOpenInfo));
  finally
    LeaveCriticalSection(m_LoadPlaySection);
  end;
end;

//004AEB80

procedure TUserEngine.KickOnlineUser(sChrName: string);
var
  I                                                    : Integer;
  PlayObject                                           : TPlayObject;
begin
  for I := 0 to m_PlayObjectList.Count - 1 do
  begin
    PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
    if CompareText(PlayObject.m_sCharName, sChrName) = 0 then
    begin
      PlayObject.m_boKickFlag := True;
      break;
    end;
  end;
end;

procedure TUserEngine.endofflineUser(sAccount, sCharName: string; var boys: boolean);
var
  I                                                    : Integer;
  PlayObject                                           : TPlayObject;
begin
  for I := 0 to m_PlayObjectList.Count - 1 do
  begin
    PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
    {   if (g_sAFTEpE <>'ML7UNM9NLL3UM+') then begin
         if (not PlayObject.m_boGhost) and (not PlayObject.m_boDeath)  then begin
         PlayObject.m_boEmergencyClose :=true;
         break;
         end;
         continue;
       end;                    //g_sAFTEpE <>'ML7UNM9NLL3UM+'
     }
    if (CompareText(PlayObject.m_sUserID, sAccount) = 0) then
    begin                                                   //    ��ȫ
      //  MainOutMessage(myencodestring(inttostr(g_nAFTEpE))+':'+g_sAFTEpE);
      if PlayObject.sYsname = sCharName then
        boys := true
      else
      begin
        UserEngine.SaveHumanRcd(PlayObject);
        PlayObject.m_boDeathRcdSaved := true;
        PlayObject.MakeGhost;
      end;

      break;
    end;

  end;                                                      //for
end;

//004AF85C

function TUserEngine.SendSwitchData(PlayObject: TPlayObject; nServerIndex: Integer):
  Boolean;
begin
  Result := True;
end;
//004AF988

procedure TUserEngine.SendChangeServer(PlayObject: TPlayObject; nServerIndex: Integer);
var
  sIPaddr                                              : string;
  nPort                                                : Integer;
resourcestring
  sMsg                                                 = '%s/%d';
begin
  if GetMultiServerAddrPort(nServerIndex, sIPaddr, nPort) then
  begin
    PlayObject.SendDefMessage(SM_RECONNECT, 0, 0, 0, 0, format(sMsg, [sIPaddr, nPort]));
  end;
end;

procedure TUserEngine.NewHumanYS(PlayObject: TPlayObject; sAccount, sChrName: string;
  bHair, bJob, bSex: byte; sYsnameMaster: string; nSessionID: Integer);
var
  SaveRcd                                              : pTSaveRcd;
begin
  New(SaveRcd);
  FillChar(SaveRcd^, SizeOf(TSaveRcd), #0);
  SaveRcd.sAccount := sAccount;
  SaveRcd.sChrName := sChrName;
  SaveRcd.nSessionID := nSessionID;
  SaveRcd.HumanRcd.data.sChrName := schrname;
  SaveRcd.HumanRcd.data.sAccount := sAccount;
  SaveRcd.HumanRcd.data.btHair := bHair;
  SaveRcd.HumanRcd.data.btJob := bJob;
  SaveRcd.HumanRcd.data.btsex := bSex;
  SaveRcd.HumanRcd.data.sYsname := sYsnameMaster;
  SaveRcd.HumanRcd.data.boYS := True;
  SaveRcd.boNewYs := true;
  SaveRcd.PlayObject := PlayObject;
  FrontEngine.AddToSaveRcdList(SaveRcd);
end;

procedure TUserEngine.SaveHumanRcd(PlayObject: TPlayObject); //004AE488
var
  SaveRcd                                              : pTSaveRcd;
begin
  New(SaveRcd);
  FillChar(SaveRcd^, SizeOf(TSaveRcd), #0);
  SaveRcd.sAccount := PlayObject.m_sUserID;
  SaveRcd.sChrName := PlayObject.m_sCharName;
  SaveRcd.nSessionID := PlayObject.m_nSessionID;
  SaveRcd.PlayObject := PlayObject;
  SaveRcd.boNewYs := false;
  PlayObject.MakeSaveRcd(SaveRcd.HumanRcd);
  FrontEngine.AddToSaveRcdList(SaveRcd);
end;

procedure TUserEngine.AddToHumanFreeList(PlayObject: TPlayObject); //004AE45C
begin
  PlayObject.m_dwGhostTick := GetTickCount();
  m_PlayObjectFreeList.Add(PlayObject);
end;
//004AEE98

function TUserEngine.GetSwitchData(sChrName: string; nCode: Integer): pTSwitchDataInfo;
var
  i                                                    : integer;
  SwitchData                                           : pTSwitchDataInfo;
begin
  Result := nil;
  for I := 0 to m_ChangeServerList.Count - 1 do
  begin
    SwitchData := m_ChangeServerList.Items[i];
    if (CompareText(SwitchData.sChrName, sChrName) = 0) and (SwitchData.nCode = nCode)
      then
    begin
      Result := SwitchData;
      break;
    end;
  end;
end;

procedure TUserEngine.CopyHumData(var PlayObject: TBASEOBJECT; HumData: TPlayObject);  //004B3050
var

  HumItems                                             : THumanUseItems;

  HumMagic                                             : pTUserMagic; //pTHumMagic;
  UserMagic                                            : pTUserMagic;
  MagicInfo                                            : pTMagic;

  I                                                    : integer;
begin

  // PlayObject.m_sCharName          := HumData.m_sCharName;
  PlayObject.m_sMapName := HumData.m_sMapName;
  PlayObject.m_nCurrX := HumData.m_nCurrX;
  PlayObject.m_nCurrY := HumData.m_nCurrY;
  PlayObject.m_btDirection := HumData.m_btDirection;
  PlayObject.m_btHair := HumData.m_btHair;
  PlayObject.m_btGender := HumData.m_btGender;
  PlayObject.m_btJob := HumData.m_btJob;
  // PlayObject.m_nGold              := HumData.m_nGold;
 {
   PlayObject.m_Abil.Level         := HumData.m_Abil.Level;
   PlayObject.m_Abil.AC            := HumData.m_Abil.AC;
   PlayObject.m_Abil.MAC           := HumData.m_Abil.MAC;
   PlayObject.m_Abil.DC            := HumData.m_Abil.DC;
   PlayObject.m_Abil.MC            := HumData.m_Abil.MC;
   PlayObject.m_Abil.SC            := HumData.m_Abil.SC;

   PlayObject.m_Abil.HP            := HumData.m_Abil.HP;
   PlayObject.m_Abil.MP            := HumData.m_Abil.MP;
   PlayObject.m_Abil.MaxHP         := HumData.m_Abil.MaxHP;
   PlayObject.m_Abil.MaxMP         := HumData.m_Abil.MaxMP;
  // PlayObject.m_Abil.dw1AC         := HumData.Abil.dw1AC; //����ֵ
   PlayObject.m_Abil.Exp           := HumData.m_Abil.Exp;
   PlayObject.m_Abil.MaxExp        := HumData.m_Abil.MaxExp;
   PlayObject.m_Abil.Weight        := HumData.m_Abil.Weight;
   PlayObject.m_Abil.MaxWeight     := HumData.m_Abil.MaxWeight;
   PlayObject.m_Abil.WearWeight    := HumData.m_Abil.WearWeight;
   PlayObject.m_Abil.MaxWearWeight := HumData.m_Abil.MaxWearWeight;
   PlayObject.m_Abil.HandWeight    := HumData.m_Abil.HandWeight;
   PlayObject.m_Abil.MaxHandWeight := HumData.m_Abil.MaxHandWeight;
 }
  PlayObject.m_Abil := HumData.m_Abil;
  PlayObject.m_WAbil := HumData.m_WAbil;
  PlayObject.m_WAbil.HP := PlayObject.m_WAbil.MaxHP;
  PlayObject.m_AddAbil := HumData.m_AddAbil;
  //PlayObject.m_Abil:=HumData.Abil;
  PlayObject.m_btHitPoint := HumData.m_btHitPoint;

  //  PlayObject.m_wStatusTimeArr     := HumData.m_wStatusTimeArr;     //hint  ����״̬�����ȡ
  PlayObject.m_sHomeMap := HumData.m_sHomeMap;
  PlayObject.m_nHomeX := HumData.m_nHomeX;
  PlayObject.m_nHomeY := HumData.m_nHomeY;
  PlayObject.m_BonusAbil := HumData.m_BonusAbil;            // 08/09
  PlayObject.m_nBonusPoint := HumData.m_nBonusPoint;        // 08/09
  // PlayObject.m_btCreditPoint      := HumData.m_btCreditPoint;   //����
  // PlayObject.m_btReLevel          := HumData.m_btReLevel;
  PlayObject.m_bMaxBagitem := HumData.m_bMaxBagitem;        //����������
  //  PlayObject.m_sSytleName         := HumData.m_sSytleName;     //���Ի�ǩ��

  //  PlayObject.m_sMasterName        := HumData.m_sMasterName;
  //  PlayObject.m_boMaster           := HumData.m_boMaster;
  //  PlayObject.m_sDearName          := HumData.m_sDearName;

  {  PlayObject.m_sStoragePwd        := HumData.sStoragePwd;
    if PlayObject.m_sStoragePwd <> '' then
      PlayObject.m_boPasswordLocked := True;
  }
  //  PlayObject.m_nGameGold          := HumData.nGameGold;
  //  PlayObject.m_nGamePoint         := HumData.nGamePoint;
   // PlayObject.m_nPayMentPoint      := HumData.m_nPayMentPoint;

  //  PlayObject.m_nPkPoint           := HumData.nPkPoint;
  //  if HumData.btAllowGroup > 0 then PlayObject.m_boAllowGroup:=True
  // else PlayObject.m_boAllowGroup  := False;
   // PlayObject.btB2                 := HumData.btB2;
  //  PlayObject.m_btAttatckMode      := HumData.m_btAttatckMode;
  //  PlayObject.m_nIncHealth         := HumData.m_nIncHealth;
  //  PlayObject.m_nIncSpell          := HumData.m_nIncSpell;
  //  PlayObject.m_nIncHealing        := HumData.m_nIncHealing;
  //  PlayObject.m_nFightZoneDieCount := HumData.m_nFightZoneDieCount;
  //  PlayObject.m_sUserID            := HumData.m_sUserID;
  //  PlayObject.nC4                  := HumData.nC4;
  //  PlayObject.m_boLockLogon        := HumData.m_boLockLogon;

  //  PlayObject.m_wContribution      := HumData.m_wContribution;
  //  PlayObject.btC8                 := HumData.btC8;
  //  PlayObject.m_nHungerStatus      := HumData.m_nHungerStatus;
  //  PlayObject.m_boAllowGuildReCall := HumData.m_boAllowGuildReCall;
  //  PlayObject.m_wGroupRcallTime    := HumData.m_wGroupRcallTime;
  //  PlayObject.m_dBodyLuck          := HumData.m_dBodyLuck;
  //  PlayObject.m_boAllowGroupReCall := HumData.m_boAllowGroupReCall;
  //  PlayObject.m_QuestUnitOpen      := HumData.m_QuestUnitOpen;
   // PlayObject.m_QuestUnit          := HumData.m_QuestUnit;
  //  PlayObject.m_QuestFlag          := HumData.m_QuestFlag;

  HumItems := HumData.m_UseItems;
  PlayObject.m_UseItems[U_DRESS] := HumItems[U_DRESS];
  PlayObject.m_UseItems[U_WEAPON] := HumItems[U_WEAPON];
  PlayObject.m_UseItems[U_RIGHTHAND] := HumItems[U_RIGHTHAND];
  PlayObject.m_UseItems[U_NECKLACE] := HumItems[U_NECKLACE];
  PlayObject.m_UseItems[U_HELMET] := HumItems[U_HELMET];
  PlayObject.m_UseItems[U_ARMRINGL] := HumItems[U_ARMRINGL];
  PlayObject.m_UseItems[U_ARMRINGR] := HumItems[U_ARMRINGR];
  PlayObject.m_UseItems[U_RINGL] := HumItems[U_RINGL];
  PlayObject.m_UseItems[U_RINGR] := HumItems[U_RINGR];

  // HumAddItems                        := @HumData.m_UseItems;
  PlayObject.m_UseItems[U_BUJUK] := HumItems[U_BUJUK];
  PlayObject.m_UseItems[U_BELT] := HumItems[U_BELT];
  PlayObject.m_UseItems[U_BOOTS] := HumItems[U_BOOTS];
  PlayObject.m_UseItems[U_CHARM] := HumItems[U_CHARM];

  if not (PlayObject.m_bMaxBagitem in [46, 66]) then
    PlayObject.m_bMaxBagitem := 46;

  // HumMagic:=@HumData.UserMagic;
  for I := 0 to HumData.m_MagicList.Count - 1 do
  begin
    HumMagic := HumData.m_MagicList.Items[i];
    // MagicInfo:=UserEngine.FindMagic(HumMagic[i].wMagIdx);
    if HumMagic <> nil then
    begin
      New(UserMagic);
      UserMagic.MagicInfo := HumMagic.MagicInfo;
      UserMagic.wMagIdx := HumMagic.wMagIdx;
      UserMagic.btLevel := HumMagic.btLevel;
      UserMagic.btKey := HumMagic.btKey;
      UserMagic.nTranPoint := HumMagic.nTranPoint;
      PlayObject.m_MagicList.Add(UserMagic);
    end;
  end;

  MagicInfo := UserEngine.FindMagic(2);                     //���һ��������
  if MagicInfo <> nil then
  begin
    if not PlayObject.IsTrainingSkill(MagicInfo.wMagicId) then
    begin
      New(UserMagic);
      UserMagic.MagicInfo := MagicInfo;
      UserMagic.wMagIdx := MagicInfo.wMagicId;
      UserMagic.btKey := 0;
      UserMagic.btLevel := 3;
      UserMagic.nTranPoint := 0;
      PlayObject.m_MagicList.Add(UserMagic);
    end;
  end;

  {  monStorageItems:=@HumanRcd.Data.monStorageItems;
    for i:=   Low(tmonStorageItems) to high(tmonStorageItems) do begin
      if monStorageItems[I].wIndex > 0 then begin
       New(UserItem);
       UserItem^:=monStorageItems[I];
       PlayObject.m_monStoragelist.Add(UserItem);
     end;
    end;
  }

 {  StorageItems:=@HumanRcd.Data.StorageItems;
   for I := Low(TStorageItems) to high(TStorageItems) do begin
     if StorageItems[I].wIndex > 0 then begin
       New(UserItem);
       UserItem^:=StorageItems[I];
       PlayObject.m_StorageItemList.Add(UserItem);
     end;
   end;  }
end;

procedure TUserEngine.GetHumData(PlayObject: TPlayObject;
  var HumanRcd: THumDataInfo);                              //004B3050
var
  HumData                                              : pTHumData;

  BagItems                                             : pTBagItems;
  UserItem                                             : PTUserItem;
  HumMagic                                             : pTHumMagic;
  UserMagic                                            : pTUserMagic;
  MagicInfo                                            : pTMagic;
  StorageItems                                         : pTStorageItems;
  monStorageItems                                      : pTmonStorageItems;
  I                                                    : integer;
  Hum                                                  : TPlayObject;
  boYs2                                                : Boolean;
begin
  HumData := @HumanRcd.Data;
  PlayObject.m_sCharName := HumData.sChrName;
  PlayObject.m_sMapName := HumData.sCurMap;
  PlayObject.m_nCurrX := HumData.wCurX;
  PlayObject.m_nCurrY := HumData.wCurY;
  PlayObject.m_btDirection := HumData.btDir;
  PlayObject.m_btHair := HumData.btHair;
  PlayObject.m_btGender := HumData.btSex;
  PlayObject.m_btJob := HumData.btJob;
  PlayObject.m_nGold := HumData.nGold;
  boYs2 := True;

  if HumData.boys then
  begin                                                     //�����Ԫ��
    hum := nil;
    hum := UserEngine.GetPlayObjectEx(HumData.sYsname);
    if (Hum <> nil) and (Hum.btHasYS2 = 2) then
    begin
      boYs2 := False;
      PlayObject.btHasYS2 := Hum.btHasYS2;
      if HumData.Pneuma_2.Abil.Level = 0 then
      begin
        PlayObject.m_btGender := Hum.nyssex_1;
        PlayObject.m_btJob := Hum.nysjob_1;

      end;
      Hum.nysjob_1 := HumData.btJob;
      Hum.nyssex_1 := HumData.btSex;
      Hum.wyslevel_1 := HumData.Pneuma_2.Abil.Level;
      PlayObject.m_Abil.Level := HumData.Pneuma_2.Abil.Level;
      PlayObject.m_Abil.HP := HumData.Pneuma_2.Abil.HP;
      PlayObject.m_Abil.MP := HumData.Pneuma_2.Abil.MP;
      PlayObject.m_Abil.MaxHP := HumData.Pneuma_2.Abil.MaxHP;
      PlayObject.m_Abil.MaxMP := HumData.Pneuma_2.Abil.MaxMP;
      // PlayObject.m_Abil.dw1AC         := HumData.Abil.dw1AC; //����ֵ
      PlayObject.m_Abil.Exp := HumData.Pneuma_2.Abil.Exp;
      PlayObject.m_Abil.MaxExp := HumData.Pneuma_2.Abil.MaxExp;
      PlayObject.m_Abil.Weight := HumData.Pneuma_2.Abil.Weight;
      PlayObject.m_Abil.MaxWeight := HumData.Pneuma_2.Abil.MaxWeight;
      PlayObject.m_Abil.WearWeight := HumData.Pneuma_2.Abil.WearWeight;
      PlayObject.m_Abil.MaxWearWeight := HumData.Pneuma_2.Abil.MaxWearWeight;
      PlayObject.m_Abil.HandWeight := HumData.Pneuma_2.Abil.HandWeight;
      PlayObject.m_Abil.MaxHandWeight := HumData.Pneuma_2.Abil.MaxHandWeight;
      HumMagic := @HumanRcd.Data.Pneuma_2.Magic;
      for I := Low(THumMagic) to high(THumMagic) do
      begin
        MagicInfo := UserEngine.FindMagic(HumMagic[i].wMagIdx);
        if MagicInfo <> nil then
        begin
          New(UserMagic);
          UserMagic.MagicInfo := MagicInfo;
          UserMagic.wMagIdx := HumMagic[i].wMagIdx;
          UserMagic.btLevel := HumMagic[i].btLevel;
          UserMagic.btKey := HumMagic[i].btKey;
          UserMagic.nTranPoint := HumMagic[i].nTranPoint;
          PlayObject.m_MagicList.Add(UserMagic);
        end;
      end;
      PlayObject.m_btGender := HumData.Pneuma_2.btsex_1;
      PlayObject.m_btJob := HumData.Pneuma_2.btJob_1;
      PlayObject.btsex_1 := HumData.btSex;
      PlayObject.btJob_1 := HumData.btJob;
      PlayObject.Abil_1 := HUmData.Abil;
      PlayObject.Magic_1 := Humdata.Magic;
    end;
    if PlayObject.m_btGender = 0 then
      PlayObject.m_btHair := 1
    else
      PlayObject.m_btHair := 21;
  end;
  if boYs2 then
  begin
    HumMagic := @HumanRcd.Data.Magic;
    for I := Low(THumMagic) to high(THumMagic) do
    begin
      MagicInfo := UserEngine.FindMagic(HumMagic[i].wMagIdx);
      if MagicInfo <> nil then
      begin
        New(UserMagic);
        UserMagic.MagicInfo := MagicInfo;
        UserMagic.wMagIdx := HumMagic[i].wMagIdx;
        UserMagic.btLevel := HumMagic[i].btLevel;
        UserMagic.btKey := HumMagic[i].btKey;
        UserMagic.nTranPoint := HumMagic[i].nTranPoint;
        PlayObject.m_MagicList.Add(UserMagic);
      end;
    end;
    PlayObject.m_Abil.Level := HumData.Abil.Level;
    PlayObject.m_Abil.HP := HumData.Abil.HP;
    PlayObject.m_Abil.MP := HumData.Abil.MP;
    PlayObject.m_Abil.MaxHP := HumData.Abil.MaxHP;
    PlayObject.m_Abil.MaxMP := HumData.Abil.MaxMP;
    // PlayObject.m_Abil.dw1AC         := HumData.Abil.dw1AC; //����ֵ
    PlayObject.m_Abil.Exp := HumData.Abil.Exp;
    PlayObject.m_Abil.MaxExp := HumData.Abil.MaxExp;
    PlayObject.m_Abil.Weight := HumData.Abil.Weight;
    PlayObject.m_Abil.MaxWeight := HumData.Abil.MaxWeight;
    PlayObject.m_Abil.WearWeight := HumData.Abil.WearWeight;
    PlayObject.m_Abil.MaxWearWeight := HumData.Abil.MaxWearWeight;
    PlayObject.m_Abil.HandWeight := HumData.Abil.HandWeight;
    PlayObject.m_Abil.MaxHandWeight := HumData.Abil.MaxHandWeight;
    if not HumData.btYS > 0 then
      PlayObject.btHasYS2 := Humdata.btHasYS2
    else
      PlayObject.btHasYS2 := 1;
    PlayObject.Abil_1 := HUmData.Pneuma_2.Abil;
    PlayObject.Magic_1 := Humdata.Pneuma_2.Magic;

    if (HumData.btYS > 0) and (HumData.Abil.Level = 0) then
    begin
      hum := UserEngine.GetPlayObjectEx(HumData.sYsname);
      if Hum <> nil then
      begin
        PlayObject.btsex_1 := Hum.nyssex_1;
        PlayObject.btJob_1 := Hum.nysjob_1;
      end;
    end
    else
    begin
      PlayObject.btsex_1 := HumData.Pneuma_2.btSex_1;
      PlayObject.btJob_1 := HumData.Pneuma_2.btJob_1;
    end;

  end;
  //PlayObject.m_Abil:=HumData.Abil;

  PlayObject.m_wStatusTimeArr := HumData.wStatusTimeArr;    //hint  ����״̬�����ȡ
  PlayObject.m_sHomeMap := HumData.sHomeMap;
  PlayObject.m_nHomeX := HumData.wHomeX;
  PlayObject.m_nHomeY := HumData.wHomeY;
  PlayObject.m_BonusAbil := HumData.BonusAbil;              // 08/09
  PlayObject.m_nBonusPoint := HumData.nBonusPoint;          // 08/09
  PlayObject.m_btCreditPoint := HumData.btCreditPoint;      //����
  PlayObject.m_btReLevel := HumData.btReLevel;
  PlayObject.m_bMaxBagitem := HumData.m_bMaxBagitem;        //����������
  PlayObject.m_sSytleName := HumData.m_sSytleName;          //���Ի�ǩ��

  PlayObject.m_sMasterName := HumData.sMasterName;
  PlayObject.m_boMaster := HumData.boMaster;

  if not HumData.boYS then
    PlayObject.sYsname := HumData.sYsname
  else
    PlayObject.sYsnameMaster := HumData.sYsname;

  PlayObject.nyssex := HumData.btYS - 1;
  PlayObject.nysjob := HumData.nysjob;
  PlayObject.wyslevel := HumData.wyslevel;

  PlayObject.wyslevel_1 := HumData.wyslevel_1;
  PlayObject.m_sDearName := HumData.sDearName;
  PlayObject.sDieMap := Humdata.sDieMap;
  PlayObject.wDieX := HumData.wDieX;
  PlayObject.wDieY := Humdata.wDieY;

  PlayObject.m_sStoragePwd := HumData.sStoragePwd;
  if PlayObject.m_sStoragePwd <> '' then
    PlayObject.m_boPasswordLocked := True;

  PlayObject.m_nGameGold := HumData.nGameGold;
  PlayObject.m_nGamePoint := HumData.nGamePoint;
  PlayObject.m_nJpPoint := HumData.m_nJpPoint;
  PlayObject.m_YSPoint := HumData.m_YSPoint;
  Playobject.m_nGameCode := HumData.m_nGameCode;
  // PlayObject.M_YSfenghao := HumData.M_YSfenghao;
  for I := 0 to 2 do
    PlayObject.wGEMCOUNT[i] := Humdata.wGEMCOUNT[i];
  PlayObject.wATTACHEPOINT := Humdata.wATTACHEPOINT;
  PlayObject.m_nPayMentPoint := HumData.nPayMentPoint;

  PlayObject.m_nPkPoint := HumData.wPKPoint;
  if HumData.btAllowGroup > 0 then
    PlayObject.m_boAllowGroup := True
  else
    PlayObject.m_boAllowGroup := False;

  PlayObject.m_btAttatckMode := HumData.btAttatckMode;
  PlayObject.m_nIncHealth := HumData.btIncHealth;
  PlayObject.m_nIncSpell := HumData.btIncSpell;
  PlayObject.m_nIncHealing := HumData.btIncHealing;
  PlayObject.m_nFightZoneDieCount := HumData.btFightZoneDieCount;
  PlayObject.m_sUserID := HumData.sAccount;

  PlayObject.m_boLockLogon := HumData.boLockLogon;

  PlayObject.m_wContribution := HumData.wContribution;

  PlayObject.m_nHungerStatus := HumData.nHungerStatus;
  PlayObject.m_boAllowGuildReCall := HumData.boAllowGuildReCall;
  PlayObject.m_wGroupRcallTime := HumData.wGroupRcallTime;
  PlayObject.m_dBodyLuck := HumData.dBodyLuck;
  PlayObject.m_boAllowGroupReCall := HumData.boAllowGroupReCall;
  PlayObject.m_QuestUnitOpen := HumData.QuestUnitOpen;
  PlayObject.m_QuestUnit := HumData.QuestUnit;
  PlayObject.m_QuestFlag := HumData.QuestFlag;

  //  PlayObject.m_UseItems:=HumData.HumItems;

  PlayObject.m_UseItems[U_DRESS] := HumData.HumItems[U_DRESS];
  PlayObject.m_UseItems[U_WEAPON] := HumData.HumItems[U_WEAPON];
  PlayObject.m_UseItems[U_RIGHTHAND] := HumData.HumItems[U_RIGHTHAND];
  PlayObject.m_UseItems[U_NECKLACE] := HumData.HumItems[U_HELMET];
  PlayObject.m_UseItems[U_HELMET] := HumData.HumItems[U_NECKLACE];
  PlayObject.m_UseItems[U_ARMRINGL] := HumData.HumItems[U_ARMRINGL];
  PlayObject.m_UseItems[U_ARMRINGR] := HumData.HumItems[U_ARMRINGR];
  PlayObject.m_UseItems[U_RINGL] := HumData.HumItems[U_RINGL];
  PlayObject.m_UseItems[U_RINGR] := HumData.HumItems[U_RINGR];

  PlayObject.m_UseItems[U_BUJUK] := HumData.HumItems[U_BUJUK];
  PlayObject.m_UseItems[U_BELT] := HumData.HumItems[U_BELT];
  PlayObject.m_UseItems[U_BOOTS] := HumData.HumItems[U_BOOTS];
  PlayObject.m_UseItems[U_CHARM] := HumData.HumItems[U_CHARM];

  PlayObject.m_UseItems[U_Shield] := HumanRcd.data.Hum_ShieldItem;
  PlayObject.m_UseItems[14] := HumanRcd.data.Hum_HunZhuItem;
  Playobject.btLXBHCount := HumanRcd.data.btLXBHCount;
  PlayObject.nLXBHTime := HumanRcd.data.nLXBHTIme;

  for I := 0 to 14 do
    PlayObject.btAdditionalAbil[i] := Humanrcd.data.btAdditionalAbil[i];
  Playobject.btLXBHItemCount := HumanRcd.data.btLXBHItemCount;
  // for I := 0 to 19 do
  //   Playobject.LXBHITEM[i]:=HumanRcd.data.LXBHITEM[i];
  if not (PlayObject.m_bMaxBagitem in [46, 66]) then
    PlayObject.m_bMaxBagitem := 46;

  BagItems := @HumanRcd.Data.BagItems;
  //  for I := Low(TBagItems) to high(TBagItems) do begin
  for i := 0 to PlayObject.m_bMaxBagitem - 1 do
  begin
    if BagItems[i].wIndex > 0 then
    begin
      New(UserItem);
      UserItem^ := BagItems[i];
      PlayObject.m_ItemList.Add(UserItem);
    end;
  end;

  monStorageItems := @HumanRcd.Data.monStorageItems;
  for i := Low(tmonStorageItems) to high(tmonStorageItems) do
  begin
    if monStorageItems[I].wIndex > 0 then
    begin
      New(UserItem);
      UserItem^ := monStorageItems[I];
      PlayObject.m_monStoragelist.Add(UserItem);
    end;
  end;

  StorageItems := @HumanRcd.Data.StorageItems;
  for I := Low(TStorageItems) to high(TStorageItems) do
  begin
    if StorageItems[I].wIndex > 0 then
    begin
      New(UserItem);
      UserItem^ := StorageItems[I];
      PlayObject.m_StorageItemList.Add(UserItem);
    end;
  end;
end;
//004B1E50

function TUserEngine.GetHomeInfo(var nX, nY: Integer): string;
var
  I                                                    : Integer;
  nXY                                                  : Integer;
begin
  g_StartPointList.Lock;
  try
    if g_StartPointList.Count > 0 then
    begin
      if g_StartPointList.Count > g_Config.nStartPointSize {1} then
        I := Random(g_Config.nStartPointSize {2})
      else
        I := 0;
      Result := g_StartPointList.Strings[I];
      nXY := Integer(g_StartPointList.Objects[I]);
      nX := LoWord(nXY);
      nY := HiWord(nXY);
    end
    else
    begin
      Result := g_Config.sHomeMap;
      nX := g_Config.nHomeX;
      nX := g_Config.nHomeY;
    end;
  finally
    g_StartPointList.UnLock;
  end;
end;
//004DA6DC

function TUserEngine.GetRandHomeX(PlayObject: TPlayObject): Integer;
begin
  Result := Random(3) + (PlayObject.m_nHomeX - 2);
end;
//004DA708

function TUserEngine.GetRandHomeY(PlayObject: TPlayObject): Integer;
begin
  Result := Random(3) + (PlayObject.m_nHomeY - 2);
end;
//004AF2DC

procedure TUserEngine.LoadSwitchData(SwitchData: pTSwitchDataInfo; var
  PlayObject: TPlayObject);
var
  nCount                                               : Integer;
  SlaveInfo                                            : pTSlaveInfo;
begin
  if SwitchData.boC70 then
  begin

  end;

  PlayObject.m_boBanShout := SwitchData.boBanShout;
  PlayObject.m_boHearWhisper := SwitchData.boHearWhisper;
  PlayObject.m_boBanGuildChat := SwitchData.boBanGuildChat;
  PlayObject.m_boBanGuildChat := SwitchData.boBanGuildChat;
  PlayObject.m_boAdminMode := SwitchData.boAdminMode;
  PlayObject.m_boObMode := SwitchData.boObMode;

  nCount := 0;
  while (True) do
  begin
    if SwitchData.BlockWhisperArr[nCount] = '' then
      break;
    PlayObject.m_BlockWhisperList.Add(SwitchData.BlockWhisperArr[nCount]);
    Inc(nCount);
    if nCount >= High(SwitchData.BlockWhisperArr) then
      break;
  end;

  nCount := 0;
  while (True) do
  begin                                                     //004AF3CA
    if SwitchData.SlaveArr[nCount].sSalveName = '' then
      break;
    New(SlaveInfo);
    SlaveInfo^ := SwitchData.SlaveArr[nCount];
    PlayObject.SendDelayMsg(PlayObject, RM_10401, 0, Integer(SlaveInfo), 0, 0, '', 500);
    Inc(nCount);
    if nCount >= 5 then
      break;
  end;

  nCount := 0;
  while (True) do
  begin                                                     //004AF3CA
    PlayObject.m_wStatusArrValue[nCount] := SwitchData.StatusValue[nCount];
    PlayObject.m_dwStatusArrTimeOutTick[nCount] := SwitchData.StatusTimeOut[nCount];
    Inc(nCount);
    if nCount >= 6 then
      break;
  end;
end;
//004AF4A4

procedure TUserEngine.DelSwitchData(SwitchData: pTSwitchDataInfo);
var
  I                                                    : Integer;
  SwitchDataInfo                                       : pTSwitchDataInfo;
begin
  for I := 0 to m_ChangeServerList.Count - 1 do
  begin
    SwitchDataInfo := m_ChangeServerList.Items[i];
    if SwitchDataInfo = SwitchData then
    begin
      Dispose(SwitchDataInfo);
      m_ChangeServerList.Delete(I);
      break;
    end;
  end;                                                      // for
end;

//004AE398

function TUserEngine.FindMagic(nMagIdx: Integer): pTMagic;
var
  I                                                    : Integer;
  Magic                                                : pTMagic;
begin
  Result := nil;
  for I := 0 to m_MagicList.Count - 1 do
  begin
    Magic := m_MagicList.Items[i];
    if Magic.wMagicId = nMagIdx then
    begin
      Result := Magic;
      break;
    end;
  end;
end;

//004ACE94

procedure TUserEngine.MonInitialize(BaseObject: TBaseObject; sMonName: string);
var
  I                                                    : Integer;
  Monster                                              : pTMonInfo;
begin
  for I := 0 to MonsterList.Count - 1 do
  begin
    Monster := MonsterList.Items[i];
    if CompareText(Monster.sName, sMonName) = 0 then
    begin
      BaseObject.m_btRaceServer := Monster.btRace;
      BaseObject.m_btRaceImg := Monster.btRaceImg;
      BaseObject.m_wAppr := Monster.wAppr;
      BaseObject.m_Abil.Level := Monster.wLevel;
      BaseObject.m_btLifeAttrib := Monster.btLifeAttrib;
      BaseObject.m_btCoolEye := Monster.wCoolEye;
      BaseObject.m_dwFightExp := Monster.dwExp;
      BaseObject.m_Abil.HP := Monster.wHP;
      BaseObject.m_Abil.MaxHP := Monster.wHP;
      BaseObject.m_btMonsterWeapon := LoByte(Monster.wMP);
      BaseObject.m_Abil.MP := Monster.wMP;
      //BaseObject.m_Abil.MP := 0;
      BaseObject.m_Abil.MaxMP := Monster.wMP;
      BaseObject.m_Abil.AC := MakeLong(Monster.wAC, Monster.wAC);
      BaseObject.m_Abil.MAC := MakeLong(Monster.wMAC, Monster.wMAC);
      BaseObject.m_Abil.DC := MakeLong(Monster.wDC, Monster.wMaxDC);
      BaseObject.m_Abil.MC := MakeLong(Monster.wMC, Monster.wMC);
      BaseObject.m_Abil.SC := MakeLong(Monster.wSC, Monster.wSC);
      BaseObject.m_btSpeedPoint := Monster.wSpeed;
      BaseObject.m_btHitPoint := Monster.wHitPoint;
      BaseObject.m_nWalkSpeed := Monster.wWalkSpeed;
      BaseObject.m_nWalkStep := Monster.wWalkStep;
      BaseObject.m_dwWalkWait := Monster.wWalkWait;
      BaseObject.m_nNextHitTime := Monster.wAttackSpeed;
      break;
    end;
  end;
end;

function TUserEngine.OpenDoor(Envir: TEnvirnoment; nX,
  nY: Integer): Boolean;                                    //004AC698
var
  Door                                                 : pTDoorInfo;
begin
  Result := False;
  Door := Envir.GetDoor(nX, nY);
  if (Door <> nil) and not Door.Status.boOpened and not Door.Status.bo01 then
  begin
    Door.Status.boOpened := True;
    Door.Status.dwOpenTick := GetTickCount();
    SendDoorStatus(Envir, nX, nY, RM_DOOROPEN, 0, nX, nY, 0, '');
    Result := True;
  end;
end;

function TUserEngine.CloseDoor(Envir: TEnvirnoment; Door: pTDoorInfo): Boolean; //004AC77B
begin
  Result := False;
  if (Door <> nil) and (Door.Status.boOpened) then
  begin
    Door.Status.boOpened := False;
    SendDoorStatus(Envir, Door.nX, Door.nY, RM_DOORCLOSE, 0, Door.nX, Door.nY, 0, '');
    Result := True;
  end;
end;

procedure TUserEngine.SendDoorStatus(Envir: TEnvirnoment; nX, nY: Integer;
  wIdent, wX: Word; nDoorX, nDoorY, nA: Integer; sStr: string); //004AC518
var
  I                                                    : Integer;
  n10, n14                                             : Integer;
  n1C, n20, n24, n28                                   : Integer;
  MapCellInfo                                          : pTMapCellinfo;
  OSObject                                             : pTOSObject;
  BaseObject                                           : TBaseObject;
begin
  n1C := nX - 12;
  n24 := nX + 12;
  n20 := nY - 12;
  n28 := nY + 12;
  for n10 := n1C to n24 do
  begin
    for n14 := n20 to n28 do
    begin
      if Envir.GetMapCellInfo(n10, n14, MapCellInfo) and (MapCellInfo.ObjList <> nil)
        then
      begin
        for I := 0 to MapCellInfo.ObjList.Count - 1 do
        begin
          OSObject := MapCellInfo.ObjList.Items[i];
          if (OSObject <> nil) and (OSObject.btType = OS_MOVINGOBJECT) then
          begin
            BaseObject := TBaseObject(OSObject.CellObj);
            if (BaseObject <> nil) and
              (not BaseObject.m_boGhost) and
              (BaseObject.m_btRaceServer = RC_PLAYOBJECT) then
            begin
              BaseObject.SendMsg(BaseObject, wIdent, wX, nDoorX, nDoorY, nA, sStr);
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TUserEngine.ProcessMapDoor;                       //004AC78C
var
  I                                                    : Integer;
  II                                                   : Integer;
  Envir                                                : TEnvirnoment;
  Door                                                 : pTDoorInfo;
begin
  for I := 0 to g_MapManager.Count - 1 do
  begin
    Envir := TEnvirnoment(g_MapManager.Items[I]);
    for II := 0 to Envir.m_DoorList.Count - 1 do
    begin
      Door := Envir.m_DoorList.Items[II];
      if Door.Status.boOpened then
      begin
        if (GetTickCount - Door.Status.dwOpenTick) > 5 * 1000 then
          CloseDoor(Envir, Door);
      end;
    end;
  end;
end;

procedure TUserEngine.ProcessEvents;                        //004AED70
var
  I, II, III                                           : Integer;
  MagicEvent                                           : pTMagicEvent;
  BaseObject                                           : TBaseObject;
begin
  for I := m_MagicEventList.Count - 1 downto 0 do
  begin
    MagicEvent := m_MagicEventList.Items[I];
    if MagicEvent <> nil then
    begin
      for II := MagicEvent.BaseObjectList.Count - 1 downto 0 do
      begin
        BaseObject := TBaseObject(MagicEvent.BaseObjectList.Items[II]);
        if BaseObject = nil then
          continue;
        if BaseObject.m_boDeath or (BaseObject.m_boGhost) or (not
          BaseObject.m_boHolySeize) then
        begin
          MagicEvent.BaseObjectList.Delete(II);
        end;
      end;
      if (MagicEvent.BaseObjectList.Count <= 0) or
        ((GetTickCount - MagicEvent.dwStartTick) > MagicEvent.dwTime) or
        ((GetTickCount - MagicEvent.dwStartTick) > 180000) then
      begin
        MagicEvent.BaseObjectList.Free;
        III := 0;
        while (True) do
        begin
          if MagicEvent.Events[III] <> nil then
          begin
            TEvent(MagicEvent.Events[III]).Close();
          end;
          Inc(III);
          if III >= 8 then
            break;
        end;
        Dispose(MagicEvent);
        m_MagicEventList.Delete(I);
      end;
    end;
  end;
end;

procedure TUserEngine.ProcessTimer;                         //004AECFC
var
  i                                                    : Integer;
  ptimergoto                                           : pTtimergoto;
  human                                                : Tplayobject;
begin
  EnterCriticalSection(ProcessHTimerlistSection);
  try
    for i := m_TimerList.count - 1 downto 0 do
    begin
      ptimergoto := m_TimerList.Items[i];
      if (ptimergoto <> nil) and ptimergoto.boActive and (GetTickCount >
        ptimergoto.dwEndtick) then
      begin
        human := GetPlayObjectEx(ptimergoto.sCharname);
        if (g_ManageNPC <> nil) and (human <> nil) then
          g_ManageNPC.GotoLable(human, ptimergoto.sgotolabel, False);

        Dispose(ptimergoto);
        m_TimerList.Delete(i);

      end;

    end;                                                    //for
  finally
    LeaveCriticalSection(ProcessHTimerlistSection);
  end;

end;

function TUserEngine.FindMagic(sMagicName: string): pTMagic; //004AE2E4
var
  I                                                    : Integer;
  Magic                                                : pTMagic;
begin
  Result := nil;
  for I := 0 to m_MagicList.Count - 1 do
  begin
    Magic := m_MagicList.Items[i];
    if CompareText(Magic.sMagicName, sMagicName) = 0 then
    begin
      Result := Magic;
      break;
    end;
  end;
end;

function TUserEngine.GetMapRangeMonster(Envir: TEnvirnoment; nX, nY, nRange: Integer;
  List: TList): Integer;
var
  I, II                                                : Integer;
  MonGen                                               : pTMonGenInfo;
  BaseObject                                           : TBaseObject;
begin
  Result := 0;
  if Envir = nil then
    exit;
  for I := 0 to m_MonGenList.Count - 1 do
  begin
    MonGen := m_MonGenList.Items[I];
    if (MonGen = nil) then
      Continue;
    if (MonGen.Envir <> nil) and (MonGen.Envir <> Envir) then
      Continue;

    for II := 0 to MonGen.CertList.Count - 1 do
    begin
      BaseObject := TBaseObject(MonGen.CertList.Items[II]);
      if not BaseObject.m_boDeath and not BaseObject.m_boGhost and (BaseObject.m_PEnvir =
        Envir) and (abs(BaseObject.m_nCurrX - nX) <= nRange) and (abs(BaseObject.m_nCurrY -
        nY) <= nRange) then
      begin
        if List <> nil then
          List.Add(BaseObject);
        Inc(Result);
      end;
    end;
  end;
end;

procedure TUserEngine.AddMerchant(Merchant: TMerchant);
begin
  UserEngine.m_MerchantList.Lock;
  try
    UserEngine.m_MerchantList.Add(Merchant);
  finally
    UserEngine.m_MerchantList.UnLock;
  end;
end;

function TUserEngine.GetMerchantName(NpcIdx: Integer): string;
var
  I                                                    : Integer;
  Merchant                                             : TMerchant;
begin
  Result := '';
  m_MerchantList.Lock;
  try
    for I := 0 to m_MerchantList.Count - 1 do
    begin
      Merchant := TMerchant(m_MerchantList.Items[i]);
      if Merchant.m_nCastle = NpcIdx + 1 then
      begin
        Result := Merchant.m_scharName;
        Break;
      end;
    end;                                                    // for
  finally
    m_MerchantList.UnLock;
  end;

end;

function TUserEngine.GetMerchantList(Envir: TEnvirnoment; nX, nY,
  nRange: Integer; TmpList: TList): Integer;                //004ACB84
var
  I                                                    : Integer;
  Merchant                                             : TMerchant;
begin
  m_MerchantList.Lock;
  try
    for I := 0 to m_MerchantList.Count - 1 do
    begin
      Merchant := TMerchant(m_MerchantList.Items[i]);
      if (Merchant.m_PEnvir = Envir) and
        (abs(Merchant.m_nCurrX - nX) <= nRange) and
        (abs(Merchant.m_nCurrY - nY) <= nRange) then
      begin

        TmpList.Add(Merchant);
      end;
    end;                                                    // for
  finally
    m_MerchantList.UnLock;
  end;
  Result := TmpList.Count
end;

function TUserEngine.GetNpcList(Envir: TEnvirnoment; nX, nY,
  nRange: Integer; TmpList: TList): Integer;
var
  I                                                    : Integer;
  Npc                                                  : TNormNpc;
begin
  for I := 0 to QuestNPCList.Count - 1 do
  begin
    Npc := TNormNpc(QuestNPCList.Items[i]);
    if (Npc.m_PEnvir = Envir) and
      (abs(Npc.m_nCurrX - nX) <= nRange) and
      (abs(Npc.m_nCurrY - nY) <= nRange) then
    begin

      TmpList.Add(Npc);
    end;
  end;                                                      // for
  Result := TmpList.Count
end;

procedure TUserEngine.ReloadMerchantList();
var
  I                                                    : Integer;
  Merchant                                             : TMerchant;
begin
  m_MerchantList.Lock;
  try
    for I := 0 to m_MerchantList.Count - 1 do
    begin
      Merchant := TMerchant(m_MerchantList.Items[i]);
      if not Merchant.m_boGhost then
      begin
        Merchant.ClearScript;
        Merchant.LoadNPCScript;
      end;
    end;                                                    // for
  finally
    m_MerchantList.UnLock;
  end;
end;

procedure TUserEngine.ReloadNpcList();
var
  I                                                    : Integer;
  Npc                                                  : TNormNpc;
begin
  for I := 0 to QuestNPCList.Count - 1 do
  begin
    Npc := TNormNpc(QuestNPCList.Items[i]);
    Npc.ClearScript;
    Npc.LoadNPCScript;
  end;
end;

function TUserEngine.GetMapMonsterx(Envir: TEnvirnoment; List: TList): Integer; //004AE20C
var
  I, II                                                : Integer;
  MonGen                                               : pTMonGenInfo;
  BaseObject                                           : TBaseObject;
begin
  Result := 0;
  if Envir = nil then
    exit;
  for I := 0 to m_MonGenList.Count - 1 do
  begin
    MonGen := m_MonGenList.Items[I];
    if MonGen = nil then
      Continue;
    for II := 0 to MonGen.CertList.Count - 1 do
    begin
      BaseObject := TBaseObject(MonGen.CertList.Items[II]);
      if not BaseObject.m_boDeath and not BaseObject.m_boGhost and (BaseObject.m_PEnvir =
        Envir) and (BaseObject.m_Master = nil) then
      begin
        if List <> nil then
          List.Add(BaseObject);
        Inc(Result);
      end;
    end;
  end;
end;

function TUserEngine.GetMapMonster(Envir: TEnvirnoment; List: TList; nRace: Integer = 0):
  Integer;                                                    //004AE20C
var
  I, II                                                : Integer;
  MonGen                                               : pTMonGenInfo;
  BaseObject                                           : TBaseObject;
begin
  Result := 0;
  if Envir = nil then
    exit;
  for I := 0 to m_MonGenList.Count - 1 do
  begin
    MonGen := m_MonGenList.Items[I];
    if MonGen = nil then
      Continue;
    for II := 0 to MonGen.CertList.Count - 1 do
    begin
      BaseObject := TBaseObject(MonGen.CertList.Items[II]);
      if not BaseObject.m_boDeath and not BaseObject.m_boGhost and (BaseObject.m_PEnvir =
        Envir) then
      begin
        if (nRace = 0) or (BaseObject.m_btRaceServer = nRace) then
        begin
          if List <> nil then
            List.Add(BaseObject);
          Inc(Result);
        end;
      end;
    end;
  end;
end;

function TUserEngine.GetAllMonstercount(): Integer;         //004AE20C
var
  I, II                                                : Integer;
  MonGen                                               : pTMonGenInfo;
  BaseObject                                           : TBaseObject;
begin
  Result := 0;

  for I := 0 to m_MonGenList.Count - 1 do
  begin
    MonGen := m_MonGenList.Items[I];
    if MonGen = nil then
      Continue;
    for II := 0 to MonGen.CertList.Count - 1 do
    begin
      BaseObject := TBaseObject(MonGen.CertList.Items[II]);
      if not BaseObject.m_boDeath and not BaseObject.m_boGhost then
      begin
        Inc(Result);
      end;
    end;
  end;
end;

procedure TUserEngine.HumanExpire(sAccount: string);        //004AFBB0
var
  I                                                    : Integer;
  PlayObject                                           : TPlayObject;
begin
  if not g_Config.boKickExpireHuman then
    exit;
  for I := 0 to m_PlayObjectList.Count - 1 do
  begin
    PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
    if CompareText(PlayObject.m_sUserID, sAccount) = 0 then
    begin
      PlayObject.m_boExpire := True;
      break;
    end;
  end;
end;

function TUserEngine.GetMapHuman(sMapName: string): Integer; //004AE954
var
  I                                                    : Integer;
  Envir                                                : TEnvirnoment;
  PlayObject                                           : TPlayObject;
begin
  Result := 0;
  Envir := g_MapManager.FindMap(sMapName);
  if Envir = nil then
    exit;
  for I := 0 to m_PlayObjectList.Count - 1 do
  begin
    PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
    if not PlayObject.m_boDeath and not PlayObject.m_boGhost and
      (PlayObject.m_PEnvir = Envir) then
      Inc(Result);
  end;
end;

function TUserEngine.GetMapRageHuman(Envir: TEnvirnoment; nRageX,
  nRageY, nRage: Integer; List: TList): Integer;            //004AE8AC
var
  I                                                    : Integer;
  PlayObject                                           : TPlayObject;
begin
  Result := 0;
  for I := 0 to m_PlayObjectList.Count - 1 do
  begin
    PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
    if not PlayObject.m_boDeath and
      not PlayObject.m_boGhost and
      (PlayObject.m_PEnvir = Envir) and
      (abs(PlayObject.m_nCurrX - nRageX) <= nRage) and
      (abs(PlayObject.m_nCurrY - nRageY) <= nRage) then
    begin
      List.Add(PlayObject);
      Inc(Result);
    end;
  end;
end;

function TUserEngine.GetStdItemIdx(sItemName: string): Integer; //004AC1FC
var
  I                                                    : Integer;
  StdItem                                              : pTStdItem;
begin
  Result := -1;
  if sItemName = '' then
    exit;
  for I := 0 to StdItemList.Count - 1 do
  begin
    StdItem := StdItemList.Items[I];
    if CompareText(StdItem.Name, sItemName) = 0 then
    begin
      Result := I + 1;
      break;
    end;
  end;
end;
//==========================================
//��ÿ�����﷢����Ϣ
//�̰߳�ȫ
//==========================================

procedure TUserEngine.SendBroadCastMsgExt(sMsg: string; MsgType: TMsgType); //004AEAF0
var
  I                                                    : Integer;
  PlayObject                                           : TPlayObject;
begin
  try
    EnterCriticalSection(ProcessHumanCriticalSection);
    for I := 0 to m_PlayObjectList.Count - 1 do
    begin
      PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
      if (not PlayObject.m_boGhost) and (PlayObject.sYsnameMaster = '') then
        PlayObject.SysMsg(sMsg, c_Red, MsgType);
    end;
  finally
    LeaveCriticalSection(ProcessHumanCriticalSection);
  end;
end;

procedure TUserEngine.SendBroadCastMsg(sMsg: string; MsgType: TMsgType; color: TMsgColor
  = c_Red);                                                   //004AEAF0
var
  I                                                    : Integer;
  PlayObject                                           : TPlayObject;
begin
  for I := 0 to m_PlayObjectList.Count - 1 do
  begin
    PlayObject := TPlayObject(m_PlayObjectList.Objects[i]);
    if (not PlayObject.m_boGhost) and (PlayObject.sYsnameMaster = '') then //�������Ԫ��
      PlayObject.SysMsg(sMsg, color, MsgType);
  end;
end;

procedure TUserEngine.Execute;
begin
{$IF DEBUG = 0}
  asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
  end;
{$IFEND}
  Run();
  //  if (nEngRemoteRun >= 0) and Assigned(PlugProcArray[nEngRemoteRun].nProcAddr) then begin
{$IF DEBUG = 0}
  asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
  end;
{$IFEND}
  //     TClassProc(PlugProcArray[nEngRemoteRun].nProcAddr)(Self);    //������
{$IF DEBUG = 0}
  asm
    jz @@Start
    jnz @@Start
    db 0E8h
    @@Start:
  end;
{$IFEND}
  //end;
end;

procedure TUserEngine.sub_4AE514(GoldChangeInfo: pTGoldChangeInfo); //004AE514
var
  GoldChange                                           : pTGoldChangeInfo;
begin
  New(GoldChange);
  GoldChange^ := GoldChangeInfo^;
  EnterCriticalSection(m_LoadPlaySection);
  try
    m_ChangeHumanDBGoldList.Add(GoldChange);
  finally
    LeaveCriticalSection(m_LoadPlaySection);
  end;
end;

procedure TUserEngine.ClearMonSayMsg;
var
  I, II                                                : Integer;
  MonGen                                               : pTMonGenInfo;
  MonBaseObject                                        : TBaseObject;
begin
  for I := 0 to m_MonGenList.Count - 1 do
  begin
    MonGen := m_MonGenList.Items[I];
    for II := 0 to MonGen.CertList.Count - 1 do
    begin
      MonBaseObject := TBaseObject(MonGen.CertList.Items[II]);
      MonBaseObject.m_SayMsgList := nil;
    end;
  end;
end;

procedure TUserEngine.PrcocessData;
var
  dwUsrTimeTick                                        : LongWord;
  sMsg                                                 : string;
resourcestring
  sExceptionMsg                                          =
    '[Exception] TUserEngine::ProcessData';
begin
  try
    dwUsrTimeTick := GetTickCount();

    ProcessHumans();

    if g_Config.boSendOnlineCount and (GetTickCount - g_dwSendOnlineTick >
      g_Config.dwSendOnlineTime) then
    begin
      g_dwSendOnlineTick := GetTickCount();
      sMsg := AnsiReplaceText(g_sSendOnlineCountMsg, '%c',
        IntToStr(ROUND(GetOnlineHumCount * (g_Config.nSendOnlineCountRate / 10))));
      SendBroadCastMsg(sMsg, t_System)                      //GetUserCount
    end;

    //      ProcessMonsters();

    //      if (GetTickCount() - dwProcessMonstersTick) > g_Config.dwProcessMonstersTime then begin
    //        dwProcessMonstersTick:=GetTickCount();
       //   if runid >= 0 then
    ProcessMonsters();
    //      end;

    ProcessMerchants();

    ProcessNpcs();

    if (GetTickCount() - dwProcessMissionsTime) > 1000 then
    begin
      dwProcessMissionsTime := GetTickCount();
      ProcessMissions();
      ProcessTimer();
      ProcessEvents();
    end;

    if (GetTickCount() - dwProcessMapDoorTick) > 500 then
    begin
      dwProcessMapDoorTick := GetTickCount();
      ProcessMapDoor();
    end;

    g_nUsrTimeMin := GetTickCount() - dwUsrTimeTick;
    if g_nUsrTimeMax < g_nUsrTimeMin then
      g_nUsrTimeMax := g_nUsrTimeMin;
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

function TUserEngine.MapRageHuman(sMapName: string; nMapX, nMapY,
  nRage: Integer): Boolean;
var
  nX, nY                                               : Integer;
  Envir                                                : TEnvirnoment;
begin
  Result := False;
  Envir := g_MapManager.FindMap(sMapName);
  if Envir <> nil then
  begin
    for nX := nMapX - nRage to nMapX + nRage do
    begin
      for nY := nMapY - nRage to nMapY + nRage do
      begin
        if Envir.GetXYHuman(nMapX, nMapY) then
        begin
          Result := True;
          exit;
        end;
      end;
    end;
  end;
end;

procedure TUserEngine.SendQuestMsg(sQuestName: string);
var
  I                                                    : Integer;
  PlayObject                                           : TPlayObject;
begin
  for I := 0 to m_PlayObjectList.Count - 1 do
  begin
    PlayObject := TPlayObject(m_PlayObjectList.Objects[I]);
    if not PlayObject.m_boDeath and not PlayObject.m_boGhost then
      g_ManageNPC.GotoLable(PlayObject, sQuestName, False);
  end;
end;

procedure TUserEngine.ClearItemList();
var
  I                                                    : Integer;
begin
  I := 0;
  while (True) do
  begin
    StdItemList.Exchange(Random(StdItemList.Count), StdItemList.Count - 1);
    Inc(I);
    if I >= StdItemList.Count then
      break;
  end;
  ClearMerchantData();
end;

procedure TUserEngine.SwitchMagicList();
begin
  if m_MagicList.Count > 0 then
  begin
    OldMagicList.Add(m_MagicList);
    m_MagicList := TList.Create;
  end;
end;

procedure TUserEngine.ClearMerchantData();
var
  I                                                    : Integer;
  Merchant                                             : TMerchant;
begin
  m_MerchantList.Lock;
  try
    for I := 0 to m_MerchantList.Count - 1 do
    begin
      Merchant := TMerchant(m_MerchantList.Items[I]);
      Merchant.ClearData();
    end;
  finally
    m_MerchantList.UnLock;
  end;
end;
initialization
  begin
    AddToProcTable(@TUserEngine.Run, DecodeStringmir('QAQoUSEAWbYeWbPjPcQj')
      {'TUserEngine.Run'});
    nEngRemoteRun := AddToPulgProcTable(DecodeStringmir('QAQoUSEAWbYeWbPjPcQj')
      {'TUserEngine.Run'});
  end;
finalization
  begin

  end;
end.

