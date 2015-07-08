unit Envir;

interface

uses
  Windows, SysUtils, Classes, Grobal2;
type
  TMapHeader = packed record
    wWidth: Word;
    wHeight: Word;
    sTitle: string[16];
    UpdateDate: TDateTime;
    Reserved: array[0..22] of Char;
  end;
  TMapUnitInfo = packed record
    wBkImg: Word; //32768 $8000 Ϊ��ֹ�ƶ�����
    wMidImg: Word;
    wFrImg: Word;
    btDoorIndex: Byte; //$80 (��¦), ���� �ĺ� �ε���
    btDoorOffset: Byte; //���� ���� �׸��� ��� ��ġ, $80 (����/����(�⺻))
    btAniFrame: Byte; //$80(Draw Alpha) +  ������ ��
    btAniTick: Byte;
    btArea: Byte; //���� ����
    btLight: Byte; //0..1..4 ���� ȿ��
  end;
  pTMapUnitInfo = ^TMapUnitInfo;
  TMap = array[0..1000 * 1000 - 1] of TMapUnitInfo;
  pTMap = ^TMap;
  TMapCellinfo = record
    chFlag: Byte;
    bt1: Byte;
    bt2: Byte;
    bt3: Byte;
    ObjList: TList;
  end;
  pTMapCellinfo = ^TMapCellinfo;

  TEnvirnoment = class
    sMapName: string; //0x4
    sMapDesc: string;
    MapCellArray: array of TMapCellinfo; //0x0C  //��ͼ����
    nMinMap: Integer; //0x10
    nServerIndex: Integer; //0x14
    nRequestLevel: Integer; //0x18 ���뱾��ͼ����ȼ�
    m_nWidth: Integer; //0x1C
    m_nHeight: Integer; //0x20
    m_boDARK: Boolean; //0x24
    m_sDelayCall:string;
    m_nDelayCallTime:Integer;
    m_boDAY: Boolean; //0x25
    m_boDarkness: Boolean;
    m_boDayLight: Boolean;
    m_DoorList: TList; //0x28
    bo2C: Boolean;
    m_boSAFE: Boolean; //0x2D
    m_boCANHORSE: Boolean;
    m_boNOBATFLY: Boolean;
    m_boCanUseLF: Boolean;
    m_boNOYS: Boolean;
    m_boNOQB: Boolean;
    m_sCanUserItem:string ;
    m_sNotAllowUseItem:string;
    m_sNotAllowUseMagic:string ;
    m_boFightZone: Boolean; //0x2E
    m_boFight3Zone: Boolean; //0x2F  //�л�ս����ͼ
    m_boQUIZ: Boolean; //0x30
    m_boNORECONNECT: Boolean; //0x31
    m_boNEEDHOLE: Boolean; //0x32
    m_boNORECALL: Boolean; //0x33
    m_boNOGUILDRECALL: Boolean;
    sMapFucx:String;
    m_boCANRECALLEVIL:Boolean ;
    m_boNODEARRECALL: Boolean;
    m_boNOMASTERRECALL: Boolean;
    m_boNORANDOMMOVE: Boolean; //0x34
    m_boNODRUG: Boolean; //0x35
    m_boMINE: Boolean; //0x36
    m_boNOPOSITIONMOVE: Boolean; //0x37
    sNoReconnectMap: string; //0x38
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
    boNODOSHOP:Boolean;
   
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
//06.1.21
    m_skillbyhumlabel: string[20];
    m_skillbymonlabel: string[20];

    m_skillhumlabel: string[20];
    m_skillmonlabel: string[20];
    m_slevelupgotolabel: string[20];

  private
    procedure Initialize(nWidth, nHeight: Integer);
  public
    constructor Create();
    destructor Destroy; override;
    function AddToMap(nX, nY: Integer; btType: Byte; pRemoveObject: TObject): Pointer;
    function CanWalk(nX, nY: Integer; boFlag: Boolean): Boolean;
    function CanWalkOfItem(nX, nY: Integer; boFlag, boItem: Boolean): Boolean;
    function CanWalkEx(nX, nY: Integer; boFlag: Boolean): Boolean;
    function CanFly(nsX, nsY, ndX, ndY: integer): Boolean;
    function MoveToMovingObject(nCX, nCY: integer; Cert: TObject; nX, nY: Integer; boFlag: Boolean): Integer;
    function GetItem(nX, nY: Integer): PTMapItem;
    function DeleteFromMap(nX, nY: Integer; btType: Byte; pRemoveObject: TObject): Integer;
    function IsCheapStuff(): Boolean;
    procedure AddDoorToMap;
    function AddToMapMineEvent(nX, nY: Integer; nType: Integer; Event: TObject): TObject;
    function LoadMapData(sMapFile: string): Boolean;
    function CreateQuest(nFlag, nValue: Integer; s24, s28, s2C: string; boGrouped: Boolean): Boolean;
    function GetMapCellInfo(nX, nY: Integer; var MapCellInfo: pTMapCellinfo): Boolean;
    function GetXYObjCount(nX, nY: Integer): Integer;
    function GetNextPosition(sx, sy, ndir, nFlag: Integer; var snx: Integer; var sny: Integer): Boolean;
    function sub_4B5FC8(nX, nY: Integer): Boolean;
    procedure VerifyMapTime(nX, nY: Integer; BaseObject: TObject);
    function CanSafeWalk(nX, nY: Integer): Boolean;
    function ArroundDoorOpened(nX, nY: Integer): Boolean;
    function GetMovingObject(nX, nY: Integer; boFlag: Boolean): Pointer;
    function GetMovingObjectNotSelf(BaseSelf: TObject; nX, nY: Integer; boFlag: Boolean): Pointer;
    function GetQuestNPC(BaseObject: TObject; sCharName, sStr: string; boFlag: Boolean): TObject;
    function GetItemEx(nX, nY: Integer; var nCount: Integer): Pointer;
    function GetDoor(nX, nY: Integer): pTDoorInfo;
    function IsValidObject(nX, nY: Integer; nRage: Integer; BaseObject: TObject): Boolean;
    function GetRangeBaseObject(nX, nY: Integer; nRage: Integer; boFlag: Boolean; BaseObjectList: TList): Integer;
    function GetBaseObjects(nX, nY: Integer; boFlag: Boolean; BaseObjectList: TList): Integer;
    function GetEvent(nX, nY: Integer): TObject;
    procedure SetMapXYFlag(nX, nY: Integer; boFlag: Boolean);
    procedure SetMapXYFlagx(nX, nY, nFlag: Integer);
    function GetXYHuman(nMapX, nMapY: Integer): Boolean;
    function GetEnvirInfo(): string;
    procedure clearMapBody;
    procedure clearMapItem;
    procedure AddObject(nType: Integer);
    procedure DelObjectCount(BaseObject: TObject);
    property MonCount: Integer read m_nMonCount;
    property HumCount: Integer read m_nHumCount;
  end;
  TMapManager = class(TGList) //004B52B0
  private
  public
    constructor Create();
    destructor Destroy; override;
    procedure LoadMapDoor();
    function AddMapInfo(sMapName, sMapDesc: string; nServerNumber: Integer; MapFlag: pTMapFlag; QuestNPC: TObject): TEnvirnoment;
    function GetMapInfo(nServerIdx: Integer; sMapName: string): TEnvirnoment;
    function AddMapRoute(sSMapNO: string; nSMapX, nSMapY: Integer; sDMapNO: string; nDMapX, nDMapY: Integer): Boolean;
    function GetMapOfServerIndex(sMapName: string): Integer;
    function FindMap(sMapName: string): TEnvirnoment;
    procedure ReSetMinMap();
    procedure Run();
    procedure ProcessMapDoor();
  end;



implementation

uses  ObjBase, ObjNpc, M2Share, Event, ObjMon, HUtil32, Castle;
var
   off: array[0..32] of integer = (1, 1, 3, 3, 3, 3, 5, 5, 7, 7, 9, 9, 9, 9, 11, 11,
   2, 2, 4, 4, 4, 4, 6, 6, 8, 8, 10, 10, 10, 10, 12, 12,5);
 off1: array[0..32] of integer = (1, 1, 3, 3, 3, 3, 5, 5, 5, 5, 7, 7, 7, 7, 9, 9,
   2, 2, 4, 4, 4, 4, 6, 6, 6, 6, 8, 8, 8, 8, 10, 10,5);
{ TEnvirList }

//004B7038

function TMapManager.AddMapInfo(sMapName, sMapDesc: string; nServerNumber: Integer; MapFlag: pTMapFlag; QuestNPC: TObject): TEnvirnoment;
var
  Envir: TEnvirnoment;
  i: Integer;
  mirror: TEnvirnoment;
begin
  Result := nil;
  Envir := TEnvirnoment.Create;
  Envir.sMapName := sMapName;
  Envir.sMapDesc := sMapDesc;
  Envir.nServerIndex := nServerNumber;
  Envir.m_boSAFE := MapFlag.boSAFE;
  Envir.m_boCANHORSE := MapFlag.boCANHORSE;
  Envir.m_boNOBATFLY := MapFlag.boNOBATFLY;
  Envir.m_boCanUseLF := MapFlag.boCanUseLF;
  Envir.m_sCanUserItem:=Mapflag.m_sCanUserItem;
  Envir.m_sNotAllowUseItem:=Mapflag.m_sNotAllowUseItem;
  Envir.m_sNotAllowUseMagic:=Mapflag.m_sNotAllowUseMagic;
  Envir.m_boNOYS := MapFlag.boNOYS;
  Envir.m_boNOQB := MapFlag.boNOQB;

  Envir.m_boFightZone := MapFlag.boFIGHT;
  Envir.m_boFight3Zone := MapFlag.boFIGHT3;
  Envir.m_boDARK := MapFlag.boDARK;
  Envir.m_sDelayCall:=MapFlag.m_sDelayCall;
  Envir.m_nDelayCallTime:=MapFlag.m_nDelayCallTime;
  Envir.m_boDAY := MapFlag.boDAY;
  Envir.m_boQUIZ := MapFlag.boQUIZ;
  Envir.m_boNORECONNECT := MapFlag.boNORECONNECT;
  Envir.m_boNEEDHOLE := MapFlag.boNEEDHOLE;
  Envir.m_boNORECALL := MapFlag.boNORECALL;
  Envir.m_boNOGUILDRECALL := MapFlag.boNOGUILDRECALL;
  Envir.m_boCANRECALLEVIL:=MapFlag.boCANRECALLEVIL;
  Envir.m_boNODEARRECALL := MapFlag.boNODEARRECALL;
  Envir.m_boNOMASTERRECALL := MapFlag.boNOMASTERRECALL;
  Envir.m_boNORANDOMMOVE := MapFlag.boNORANDOMMOVE;
  Envir.m_boNODRUG := MapFlag.boNODRUG;
  Envir.m_boMINE := MapFlag.boMINE;
  Envir.m_boNOPOSITIONMOVE := MapFlag.boNOPOSITIONMOVE;
  Envir.sMapFucx:=MapFLag.smapFucx;
  Envir.m_boRUNHUMAN := MapFlag.boRUNHUMAN; //���Դ���
  Envir.m_boRUNMON := MapFlag.boRUNMON; //���Դ���
  Envir.m_boDECHP := MapFlag.boDECHP; //�Զ���HPֵ
  Envir.m_boINCHP := MapFlag.boINCHP; //�Զ���HPֵ
  Envir.m_boDECGAMEGOLD := MapFlag.boDECGAMEGOLD; //�Զ�����Ϸ��
  Envir.m_boDECGAMEPOINT := MapFlag.boDECGAMEPOINT; //�Զ�����Ϸ��
  Envir.m_boINCGAMEGOLD := MapFlag.boINCGAMEGOLD; //�Զ�����Ϸ��
  Envir.m_boINCGAMEPOINT := MapFlag.boINCGAMEPOINT; //�Զ�����Ϸ��
  Envir.m_boMUSIC := MapFlag.boMUSIC; //����
  Envir.m_boEXPRATE := MapFlag.boEXPRATE; //ɱ�־��鱶��
  Envir.m_boPKWINLEVEL := MapFlag.boPKWINLEVEL; //PK�õȼ�
  Envir.m_boPKWINEXP := MapFlag.boPKWINEXP; //PK�þ���
  Envir.m_boPKLOSTLEVEL := MapFlag.boPKLOSTLEVEL;
  Envir.m_boPKLOSTEXP := MapFlag.boPKLOSTEXP;
  Envir.m_nPKWINLEVEL := MapFlag.nPKWINLEVEL; //PK�õȼ���
  Envir.m_nPKWINEXP := MapFlag.nPKWINEXP; //PK�þ�����
  Envir.m_nPKLOSTLEVEL := MapFlag.nPKLOSTLEVEL;
  Envir.m_nPKLOSTEXP := MapFlag.nPKLOSTEXP;
  Envir.m_nPKWINEXP := MapFlag.nPKWINEXP; //PK�þ�����
  Envir.m_nDECHPTIME := MapFlag.nDECHPTIME; //��HP���ʱ��
  Envir.m_nDECHPPOINT := MapFlag.nDECHPPOINT; //һ�μ�����
  Envir.m_nINCHPTIME := MapFlag.nINCHPTIME; //��HP���ʱ��
  Envir.m_nINCHPPOINT := MapFlag.nINCHPPOINT; //һ�μӵ���
  Envir.m_nDECGAMEGOLDTIME := MapFlag.nDECGAMEGOLDTIME; //����Ϸ�Ҽ��ʱ��
  Envir.m_nDECGAMEGOLD := MapFlag.nDECGAMEGOLD; //һ�μ�����
  Envir.m_nINCGAMEGOLDTIME := MapFlag.nINCGAMEGOLDTIME; //����Ϸ�Ҽ��ʱ��
  Envir.m_nINCGAMEGOLD := MapFlag.nINCGAMEGOLD; //һ�μ�����
  Envir.m_nINCGAMEPOINTTIME := MapFlag.nINCGAMEPOINTTIME; //����Ϸ�Ҽ��ʱ��
  Envir.m_nINCGAMEPOINT := MapFlag.nINCGAMEPOINT; //һ�μ�����
  Envir.m_nMUSICID := MapFlag.nMUSICID; //����ID
  Envir.m_nEXPRATE := MapFlag.nEXPRATE; //���鱶��

  Envir.boNODOSHOP:=MapFlag.boNODOSHOP;

  Envir.sNoReconnectMap := MapFlag.sReConnectMap;
  Envir.QuestNPC := QuestNPC;
  Envir.nNEEDSETONFlag := MapFlag.nNEEDSETONFlag;
  Envir.nNeedONOFF := MapFlag.nNeedONOFF;
  Envir.mirrorname := MapFlag.mirrorname;
  Envir.m_weatherEffect := MapFlag.m_weatherEffect;
  Envir.m_WindSpeed:=MapFlag.m_WindSpeed;
  Envir.m_WinsColor:=MapFlag.m_WinsColor;

  Envir.m_nQfunction := MapFlag.m_nQfunction;
//
  Envir.m_skillbyhumlabel := MapFlag.m_skillbyhumlabel;
  Envir.m_skillbymonlabel := MapFlag.m_skillbymonlabel;
  Envir.m_skillhumlabel := MapFlag.m_skillhumlabel;
  Envir.m_skillmonlabel := MapFlag.m_skillmonlabel;
  Envir.m_slevelupgotolabel := MapFlag.m_slevelupgotolabel;



  for i := 0 to MiniMapList.Count - 1 do
  begin
    if CompareText(MiniMapList.Strings[i], Envir.sMapName) = 0 then
    begin
      Envir.nMinMap := Integer(MiniMapList.Objects[i]);
      break;
    end;
  end;
  if Envir.mirrorname <> '' then
  begin //�����ͼ
    mirror := GetMapInfo(nServerNumber, Envir.mirrorname);
   // pointer(Envir.MapCellArray):=pointer(mirror.MapCellArray);
    if mirror = nil then
    begin
      if Envir.LoadMapData(g_Config.sMapDir + Envir.mirrorname + '.nmp') then
    begin //'.map'
      Result := Envir;
      Self.Add(Envir);
      Exit;
    end
    //  MainOutMessage('�����ͼ ' + Envir.sMapName + ' ����ʧ�ܣ�ԭʼ��ͼ' + Envir.mirrorname + 'δ���أ�����');
   //   Envir.Free; //hint��
    //  exit;
    end;
    Envir.m_nWidth := mirror.m_nWidth;
    Envir.m_nHeight := mirror.m_nHeight;
    Envir.Initialize(Envir.m_nWidth, Envir.m_nHeight);
    copymemory(@Envir.MapCellArray[0], @mirror.MapCellArray[0], (Envir.m_nWidth * Envir.m_nHeight) * SizeOf(TMapCellinfo));
    Result := Envir;
    Self.Add(Envir);
  end
  else
  begin
    if UpperCase(sMapName)='TG51' then
      sMapName:='TG51';
    if Envir.LoadMapData(g_Config.sMapDir + sMapName + '.nmp') then
    begin //'.map'
      Result := Envir;
      Self.Add(Envir);
    end
    else
    begin

      MainOutMessage('��ͼ�ļ� ' + g_Config.sMapDir + sMapName + '.nmp' + ' δ�ҵ�,���߼��س�������');
      Envir.Free; //hint��
    end;

  end; //else
end;
//004B7280

function TMapManager.AddMapRoute(sSMapNO: string; nSMapX, nSMapY: Integer; sDMapNO: string; nDMapX, nDMapY: Integer): Boolean;
var
  GateObj: pTGateObj;
  SEnvir: TEnvirnoment;
  DEnvir: TEnvirnoment;
begin
  Result := False;
  SEnvir := FindMap(sSMapNO);
  DEnvir := FindMap(sDMapNO);
  if (SEnvir <> nil) and (DEnvir <> nil) then
  begin
    New(GateObj);
    GateObj.boFlag := False;
    GateObj.DEnvir := DEnvir;
    GateObj.nDMapX := nDMapX;
    GateObj.nDMapY := nDMapY;
    if SEnvir.AddToMap(nSMapX, nSMapY, OS_GATEOBJECT, TObject(GateObj)) <> nil then
      Result := True
    else
      dispose(GateObj); //hint й¶
  end;

end;
//004B63E4

function TEnvirnoment.AddToMap(nX, nY: Integer; btType: Byte;
  pRemoveObject: TObject): Pointer;
var
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  MapItem: PTMapItem;
  i: integer;
  nGoldCount, Ecode: Integer;
  bo1E: Boolean;
  btRaceServer: Byte;
resourcestring
  sExceptionMsg = '[Exception] TEnvirnoment::AddToMap ECode %d';
begin
  Result := nil;
  try
    bo1E := False;
    if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag in [0, 3]) then
    begin
      Ecode := 0;
      if MapCellInfo.ObjList = nil then
      begin
        MapCellInfo.ObjList := TList.Create;
      end
      else
      begin
        if btType = OS_ITEMOBJECT then
        begin
          Ecode := 1;
          if PTMapItem(pRemoveObject).Name = sSTRING_GOLDNAME then
          begin
            for i := 0 to MapCellInfo.ObjList.Count - 1 do
            begin
              OSObject := MapCellInfo.ObjList.Items[i];
              if OSObject.CellObj = nil then
                continue;
              if OSObject.btType = OS_ITEMOBJECT then
              begin
                MapItem := PTMapItem(pTOSObject(MapCellInfo.ObjList.Items[i]).CellObj);
                if MapItem.Name = sSTRING_GOLDNAME then
                begin
                  nGoldCount := MapItem.Count + PTMapItem(pRemoveObject).Count;
                  if nGoldCount <= 2000 then
                  begin
                    MapItem.Count := nGoldCount;
                    MapItem.Looks := GetGoldShape(nGoldCount);
                    MapItem.AniCount := 0;
                    MapItem.Reserved := 0;
                    OSObject.dwAddTime := GetTickCount();
                    Result := MapItem;
                    bo1E := True;
                    Ecode := 2;
                  end;
                end;
              end;
            end; //004B653D
          end; //004B653D
          if not bo1E and (MapCellInfo.ObjList.Count >= 5) then
          begin
            Result := nil;
            bo1E := True;
            Ecode := 3;
          end; //004B6558
        end; //004B6558
        if btType = OS_EVENTOBJECT then
        begin

        end;
      end; //004B655C
      if not bo1E then
      begin
        Ecode := 4;
        New(OSObject);
        OSObject.btType := btType;
        OSObject.CellObj := pRemoveObject;
        OSObject.dwAddTime := GetTickCount();
        MapCellInfo.ObjList.Add(OSObject);
        Result := Pointer(pRemoveObject);

        if (btType = OS_MOVINGOBJECT) and (not TBaseObject(pRemoveObject).m_boAddToMaped) then
        begin
          TBaseObject(pRemoveObject).m_boDelFormMaped := False;
          TBaseObject(pRemoveObject).m_boAddToMaped := True;
          btRaceServer := TBaseObject(pRemoveObject).m_btRaceServer;
          Ecode := 5;
          if btRaceServer = RC_PLAYOBJECT then
            Inc(m_nHumCount);
          if btRaceServer >= RC_ANIMAL then
            Inc(m_nMonCount);
        end;

      end; //004B659F

    end; //004B659F
  except
   // MainOutMessage(sExceptionMsg);

    on e: Exception do
    begin
      MainOutMessage(format(sExceptionMsg, [Ecode]));
      MainOutMessage(E.Message);
      raise;
    end;

  end;
end;

procedure TEnvirnoment.AddDoorToMap(); //004B6A74
var
  i: integer;
  Door: pTDoorInfo;
begin
  for i := 0 to m_DoorList.Count - 1 do
  begin
    Door := m_DoorList.Items[i];
    AddToMap(Door.nX, Door.nY, OS_DOOR, TObject(Door));
  end;
end;

function TEnvirnoment.GetMapCellInfo(nX, nY: Integer; var MapCellInfo: pTMapCellinfo): Boolean; //004B57D8
begin
  MapCellInfo := nil;
  Result := False;
  if (nX >= 0) and (nX < m_nWidth) and (nY >= 0) and (nY < m_nHeight) then
  begin
    MapCellInfo := @MapCellArray[nX * m_nHeight + nY];
    if MapCellInfo <> nil then
      Result := True;
  end;
end;

function TEnvirnoment.MoveToMovingObject(nCX, nCY: integer; Cert: TObject; nX, nY: Integer; boFlag: Boolean): Integer; //004B612C
var
  MapCellInfo: pTMapCellinfo;
  BaseObject: TBaseObject;
  OSObject: pTOSObject;
  i: Integer;
  bo1A: Boolean;
  delok: boolean;
resourcestring
  sExceptionMsg = '[Exception] TEnvirnoment::MoveToMovingObject';
label
  Loop, Over;
begin
  Result := 0;
  delok := false;
  try
    bo1A := True;
    if not boFlag and GetMapCellInfo(nX, nY, MapCellInfo) then
    begin
      if MapCellInfo.chFlag = 0 then
      begin
        if MapCellInfo.ObjList <> nil then
        begin
          for i := 0 to MapCellInfo.ObjList.Count - 1 do
          begin //004B61AD
            if pTOSObject(MapCellInfo.ObjList.Items[i]).btType = OS_MOVINGOBJECT then
            begin
              BaseObject := TBaseObject(pTOSObject(MapCellInfo.ObjList.Items[i]).CellObj);
              if BaseObject <> nil then
              begin //004B61DB
                if not BaseObject.m_boGhost
                  and BaseObject.bo2B9
                  and not BaseObject.m_boDeath
                  and not BaseObject.m_boFixedHideMode
                  and not BaseObject.m_boObMode then
                begin
                  bo1A := False;
                  Break;
                end;
              end; //004B6223
            end; //004B6223
          end; //004B622D
        end; //004B6238
      end
      else
      begin //004B622D   if MapCellInfo.chFlag = 0 then begin
        Result := -1;
        bo1A := False;
      end; //004B6238
    end; //004B6238
    if bo1A then
    begin //004B6238
      if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag <> 0) then
      begin
        Result := -1;
      end
      else
      begin //004B6265
        if GetMapCellInfo(nCX, nCY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then
        begin
          i := 0;
          while (True) do
          begin
            if MapCellInfo.ObjList.Count <= i then
              break;
            OSObject := MapCellInfo.ObjList.Items[i];
            if osobject = nil then
            begin //��ģ���Ұ�����ˡ�д��ô�����ѭ��
              MapCellInfo.ObjList.Delete(i); //������ ����������
              continue;
            end;
            if OSObject.btType = OS_MOVINGOBJECT then
            begin
              if TBaseObject(OSObject.CellObj) = TBaseObject(Cert) then
              begin
                MapCellInfo.ObjList.Delete(i);
                delok := true;
                Dispose(OSObject);
                if MapCellInfo.ObjList.Count > 0 then
                  Continue;
                MapCellInfo.ObjList.Free;
                MapCellInfo.ObjList := nil;
                break;
              end;
            end;
            Inc(i);
          end;
        end; //4B6311
        if GetMapCellInfo(nX, nY, MapCellInfo) and delok then
        begin
          if (MapCellInfo.ObjList = nil) then
          begin
            MapCellInfo.ObjList := TList.Create;
          end;
          New(OSObject);
          OSObject.btType := OS_MOVINGOBJECT;
          OSObject.CellObj := Cert;
          OSObject.dwAddTime := GetTickCount;
          MapCellInfo.ObjList.Add(OSObject);
          Result := 1;
        end; //004B6383
      end; //004B6383
    end; //004B6383
  except
    on e: Exception do
    begin
      MainOutMessage(sExceptionMsg);
      MainOutMessage(E.Message);
      raise;
    end;

  end;
//  pMapCellInfo = GetMapCellInfo(nX, nY);
end;
//======================================================================
//����ͼָ�������Ƿ�����ƶ�
//boFlag  ���ΪTRUE ������������Ƿ��н�ɫ
//����ֵ True Ϊ�����ƶ���False Ϊ�������ƶ�
//======================================================================

function TEnvirnoment.CanWalk(nX, nY: Integer; boFlag: Boolean): Boolean; //004B5ED0
var
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
  i: Integer;
begin
  Result := False;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 0) then
  begin
    Result := True;
    if not boFlag and (MapCellInfo.ObjList <> nil) then
    begin
      for i := 0 to MapCellInfo.ObjList.Count - 1 do
      begin
        OSObject := MapCellInfo.ObjList.Items[i];
        if OSObject = nil then
        begin // 2006,8,3 B7  ����

          continue; //
        end; //
        if OSObject.btType = OS_MOVINGOBJECT then
        begin
          BaseObject := TBaseObject(OSObject.CellObj);
          if BaseObject <> nil then
          begin
            if not BaseObject.m_boGhost
              and BaseObject.bo2B9
              and not BaseObject.m_boDeath
              and not BaseObject.m_boFixedHideMode
              and not BaseObject.m_boObMode then
            begin
              Result := False;
              Break;
            end;
          end; //004B5FB5
        end; //004B5FB5
      end;
    end;
  end; //004B5FBD
end;

//======================================================================
//����ͼָ�������Ƿ�����ƶ�
//boFlag  ���ΪTRUE ������������Ƿ��н�ɫ
//����ֵ True Ϊ�����ƶ���False Ϊ�������ƶ�
//======================================================================

function TEnvirnoment.CanWalkOfItem(nX, nY: Integer; boFlag, boItem: Boolean): Boolean; //004B5ED0
var
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
  i: Integer;
begin
  Result := True;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 0) then
  begin
//    Result:=True;
    if (MapCellInfo.ObjList <> nil) then
    begin
      for i := 0 to MapCellInfo.ObjList.Count - 1 do
      begin
        OSObject := MapCellInfo.ObjList.Items[i];
        if OSObject = nil then
          continue;
        if not boFlag and (OSObject.btType = OS_MOVINGOBJECT) then
        begin
          BaseObject := TBaseObject(OSObject.CellObj);
          if BaseObject <> nil then
          begin
            if not BaseObject.m_boGhost
              and BaseObject.bo2B9
              and not BaseObject.m_boDeath
              and not BaseObject.m_boFixedHideMode
              and not BaseObject.m_boObMode then
            begin
              Result := False;
              Break;
            end;
          end; //004B5FB5
        end; //004B5FB5
        if not boItem and (OSObject.btType = OS_ITEMOBJECT) then
        begin
          Result := False;
          break;
        end;
      end;
    end;
  end; //004B5FBD
end;

function TEnvirnoment.CanWalkEx(nX, nY: Integer; boFlag: Boolean): Boolean; //004B5ED0
var
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
  i: Integer;
  Castle: TUserCastle;
begin
  Result := False;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 0) then
  begin
    Result := True;
    if not boFlag and (MapCellInfo.ObjList <> nil) then
    begin
      for i := 0 to MapCellInfo.ObjList.Count - 1 do
      begin
        OSObject := MapCellInfo.ObjList.Items[i];
        if OSObject = nil then
          continue;
        if OSObject.btType = OS_MOVINGOBJECT then
        begin
          BaseObject := TBaseObject(OSObject.CellObj);
          if BaseObject <> nil then
          begin
            {//01/25 ��Ǳ� ����
            if g_Config.boWarDisHumRun and UserCastle.m_boUnderWar and
              UserCastle.InCastleWarArea(BaseObject.m_PEnvir,BaseObject.m_nCurrX,BaseObject.m_nCurrY) then begin
            }
            Castle := g_CastleManager.InCastleWarArea(BaseObject);
            if g_Config.boWarDisHumRun and (Castle <> nil) and (Castle.m_boUnderWar) then
            begin
            end
            else
            begin
              if BaseObject.m_btRaceServer = RC_PLAYOBJECT then
              begin
                if g_Config.boRunHuman or m_boRUNHUMAN then
                  Continue;
              end
              else
              begin
                if BaseObject.m_btRaceServer = RC_NPC then
                begin
                  if g_Config.boRunNpc then
                    Continue;
                end
                else
                begin
                  if BaseObject.m_btRaceServer in [RC_GUARD, RC_ARCHERGUARD] then
                  begin
                    if g_Config.boRunGuard then
                      Continue;
                  end
                  else
                  begin
                    if g_Config.boRunMon or m_boRUNMON then
                      Continue;
                  end;
                end;
              end;
            end;

            if not BaseObject.m_boGhost
              and BaseObject.bo2B9
              and not BaseObject.m_boDeath
              and not BaseObject.m_boFixedHideMode
              and not BaseObject.m_boObMode then
            begin
              Result := False;
              Break;
            end;
          end; //004B5FB5
        end; //004B5FB5
      end;
    end;
  end; //004B5FBD
end;

constructor TMapManager.Create;
begin
  inherited Create;
end;

destructor TMapManager.Destroy;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    TEnvirnoment(Items[I]).Free;
  end;
  inherited;
end;
     //Envir:TEnvirnoment

function TMapManager.FindMap(sMapName: string): TEnvirnoment; //4B7350
var
  Map: TEnvirnoment;
  i: Integer;
begin
  Result := nil;
  Lock;
  try
    for i := 0 to Count - 1 do
    begin
      Map := TEnvirnoment(Items[i]);
      if CompareText(Map.sMapName, sMapName) = 0 then
      begin
        Result := Map;
        Break;
      end;
    end;
  finally
    UnLock;
  end;
end;

function TMapManager.GetMapInfo(nServerIdx: Integer; sMapName: string): TEnvirnoment; //004B7424
var
  i: Integer;
  Envir: TEnvirnoment;
begin
  Result := nil;
  Lock;
  try
    for i := 0 to Count - 1 do
    begin
      Envir := Items[i];
      if (Envir.nServerIndex = nServerIdx) and (CompareText(Envir.sMapName, sMapName) = 0) then
      begin
        Result := Envir;
        break;
      end;
    end; 
  finally
    Unlock;
  end;
end;

function TEnvirnoment.DeleteFromMap(nX, nY: Integer; btType: Byte;
  pRemoveObject: TObject): Integer; //004B6710
var
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  n18: integer;
  btRaceServer: Byte;
resourcestring
  sExceptionMsg1 = '[Exception] TEnvirnoment::DeleteFromMap -> Except 1 ** %d';
  sExceptionMsg2 = '[Exception] TEnvirnoment::DeleteFromMap -> Except 2 ** %d';
begin
  Result := -1;
  try
    if GetMapCellInfo(nX, nY, MapCellInfo) then
    begin
      if MapCellInfo <> nil then
      begin
        try
          if MapCellInfo.ObjList <> nil then
          begin
            n18 := 0;
            while (True) do
            begin
              if MapCellInfo.ObjList.Count <= n18 then
                break;
              OSObject := MapCellInfo.ObjList.Items[n18];


              if OSObject <> nil then
              begin
                if (OSObject.btType = btType) and (OSObject.CellObj = pRemoveObject) then
                begin
                  MapCellInfo.ObjList.Delete(n18);
                  DisPose(OSObject);
                  Result := 1;
                  //����ͼ����������
                  if (btType = OS_MOVINGOBJECT) and (not TBaseObject(pRemoveObject).m_boDelFormMaped) then
                  begin
                    TBaseObject(pRemoveObject).m_boDelFormMaped := True;
                    TBaseObject(pRemoveObject).m_boAddToMaped := False;
                    btRaceServer := TBaseObject(pRemoveObject).m_btRaceServer;
                    if btRaceServer = RC_PLAYOBJECT then
                      dec(m_nHumCount);
                    if btRaceServer >= RC_ANIMAL then
                      dec(m_nMonCount);
                  end;

                  if MapCellInfo.ObjList.Count > 0 then
                    Continue;
                  MapCellInfo.ObjList.Free;
                  MapCellInfo.ObjList := nil;
                  break;

                end
              end
              else
              begin
                if n18 < MapCellInfo.ObjList.Count then
                  MapCellInfo.ObjList.Delete(n18);
                if MapCellInfo.ObjList.Count > 0 then
                  Continue;
                MapCellInfo.ObjList.Free;
                MapCellInfo.ObjList := nil;
                break;
              end;
              Inc(n18);
            end;
          end
          else
          begin
            Result := -2;
          end;
        except
          OSObject := nil;
          MainOutMessage(format(sExceptionMsg1, [btType]));
        end;
      end
      else
        Result := -3;
    end
    else
      Result := 0;
  except
    MainOutMessage(format(sExceptionMsg2, [btType]));
  end;
end;

function TEnvirnoment.GetItem(nX, nY: Integer): PTMapItem; //004B5B0C
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  Result := nil;
  bo2C := False;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 0) then
  begin
    bo2C := True;
    if MapCellInfo.ObjList <> nil then
    begin
      for I := 0 to MapCellInfo.ObjList.Count - 1 do
      begin
        OSObject := MapCellInfo.ObjList.Items[i];
        if OSObject = nil then
          continue;
        if OSObject.btType = OS_ITEMOBJECT then
        begin
          Result := PTMapItem(OSObject.CellObj);
          exit;
        end;
        if OSObject.btType = OS_GATEOBJECT then
          bo2C := False;
        if OSObject.btType = OS_MOVINGOBJECT then
        begin
          BaseObject := TBaseObject(OSObject.CellObj);
          if not BaseObject.m_boDeath then
            bo2C := False;
        end;
      end;
    end;
  end;
end;

function TMapManager.GetMapOfServerIndex(sMapName: string): Integer; //004B7510
var
  i: Integer;
  Envir: TEnvirnoment;
begin
  Result := 0;
  Lock;
  try
    for i := 0 to Count - 1 do
    begin
      Envir := Items[i];
      if (CompareText(Envir.sMapName, sMapName) = 0) then
      begin
        Result := Envir.nServerIndex;
        break;
      end;
    end;
  finally
    UnLock;
  end;
end;

procedure TMapManager.LoadMapDoor; //004B6FFC
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
  begin
    TEnvirnoment(Items[i]).AddDoorToMap;
  end;
end;

procedure TMapManager.ProcessMapDoor;
begin

end;

procedure TMapManager.ReSetMinMap;
var
  I, II: Integer;
  Envirnoment: TEnvirnoment;
begin
  for I := 0 to Count - 1 do
  begin
    Envirnoment := TEnvirnoment(Items[I]);
    for II := 0 to MiniMapList.Count - 1 do
    begin
      if CompareText(MiniMapList.Strings[II], Envirnoment.sMapName) = 0 then
      begin
        Envirnoment.nMinMap := Integer(MiniMapList.Objects[II]);
        break;
      end;
    end;
  end;
end;

function TEnvirnoment.IsCheapStuff: Boolean; //004B6E24
begin
  if m_QuestList.Count > 0 then
    Result := True
  else
    Result := False;
end;

function TEnvirnoment.AddToMapMineEvent(nX, nY: Integer; nType: Integer; Event: TObject): TObject; //004B6600
var
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  bo19, bo1A: Boolean;
resourcestring
  sExceptionMsg = '[Exception] TEnvirnoment::AddToMapMineEvent ';
begin
  Result := nil;
  try
    bo19 := GetMapCellInfo(nX, nY, MapCellInfo);
    bo1A := False;
    if bo19 and (MapCellInfo.chFlag <> 0) then
    begin
      if MapCellInfo.ObjList = nil then
        MapCellInfo.ObjList := TList.Create;
      if not bo1A then
      begin
        New(OSObject);
        OSObject.btType := nType;
        OSObject.CellObj := Event;
        OSObject.dwAddTime := GetTickCount();
        MapCellInfo.ObjList.Add(OSObject);
        Result := Event;
      end;
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

procedure TEnvirnoment.VerifyMapTime(nX, nY: Integer; BaseObject: TObject); //004B6980
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  boVerify: Boolean;
resourcestring
  sExceptionMsg = '[Exception] TEnvirnoment::VerifyMapTime';
begin
  try
    boVerify := False;
    if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo <> nil) and (MapCellInfo.ObjList <> nil) then
    begin
      for I := 0 to MapCellInfo.ObjList.Count - 1 do
      begin
        OSObject := MapCellInfo.ObjList.Items[i];
        if OSObject = nil then
          continue;
        if (OSObject.btType = OS_MOVINGOBJECT) and (OSObject.CellObj = BaseObject) then
        begin
          OSObject.dwAddTime := GetTickCount();
          boVerify := True;
          break;
        end;
      end;
    end;
    if not boVerify then
      AddToMap(nX, nY, OS_MOVINGOBJECT, BaseObject);
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

constructor TEnvirnoment.Create; //004B5318
begin
 // Pointer(MapCellArray) := nil;
  Setlength(MapCellArray, 0);
  sMapName := '';
  nServerIndex := 0;
  nMinMap := 0;
  m_nWidth := 0;
  m_nHeight := 0;
  m_boDARK := False;
  m_boDAY := False;
  m_nMonCount := 0;
  m_nHumCount := 0;

  m_DoorList := TList.Create;
  m_QuestList := TList.Create;
 
end;

destructor TEnvirnoment.Destroy;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  nX, nY: Integer;
  DoorInfo: pTDoorInfo;
begin
  for nX := 0 to m_nWidth - 1 do
  begin
    for nY := 0 to m_nHeight - 1 do
    begin
      if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then
      begin
        for I := 0 to MapCellInfo.ObjList.Count - 1 do
        begin
          OSObject := MapCellInfo.ObjList.Items[I];
          case OSObject.btType of
            OS_ITEMOBJECT: Dispose(PTMapItem(OSObject.CellObj));
            OS_GATEOBJECT: Dispose(pTGateObj(OSObject.CellObj));
            OS_EVENTOBJECT: TEvent(OSObject.CellObj).Free;

          end;
          Dispose(OSObject);
        end;
        MapCellInfo.ObjList.Free;
        MapCellInfo.ObjList := nil;
      end;
    end;
  end;



  for I := 0 to m_DoorList.Count - 1 do
  begin
    DoorInfo := m_DoorList.Items[I];
    Dec(DoorInfo.Status.nRefCount);
    if DoorInfo.Status.nRefCount <= 0 then
      Dispose(DoorInfo.Status);

    Dispose(DoorInfo);
  end;
  m_DoorList.Free;
  for I := 0 to m_QuestList.Count - 1 do
  begin
    Dispose(pTMapQuestInfo(m_QuestList.Items[I]));
  end;
  m_QuestList.Free;
  Setlength(MapCellArray, 0);
  inherited;
end;

function TEnvirnoment.LoadMapData(sMapFile: string): Boolean; //004B54E0
var
  fHandle: Integer;
  Header: Tnmpfileheader; // TMapHeader;
  nMapSize: Integer;
  n24, nW, nH: Integer;
  MapBuffer: pNMPTMap;



  MapCellinfo: pTMapCellinfo;
  nmpcellflag1: pTnmpcellflag1;
  step: integer;
  error: boolean;
begin
  Result := False;
  error := false;
  if FileExists(sMapFile) then
  begin

    fHandle := FileOpen(sMapFile, fmOpenRead or fmShareExclusive);
    if fHandle > 0 then
    begin
      FileRead(fHandle, Header, SizeOf(Tnmpfileheader));
//      if not (Header.flag in [1, 3]) then
//      begin
//        FileClose(fHandle);
//        exit;
//      end;

      m_nWidth := Header.X;
      m_nHeight := Header.Y;
      Initialize(m_nWidth, m_nHeight); //�����Ѿ���ʼ�� MapCellArray
    //  nMapSize:=m_nWidth * SizeOf(TNMPMapUnitInfo) * m_nHeight ;
      nMapSize := filesize(sMapFile) - SizeOf(Tnmpfileheader);
      MapBuffer := AllocMem(nMapSize); // nMapSize
      FileRead(fHandle, MapBuffer^, nMapSize);
      step := 0; // MapCellInfo.chFlag  =0 ��ʾ������
      for nH := 0 to m_nHeight - 1 do
      begin

        for nW := 0 to m_nWidth - 1 do
        begin
          n24 := nW * m_nHeight;

          MapCellinfo := @MapCellArray[n24 + nH];


          if Header.flag <> 1 then
          begin
            MapCellinfo.chFlag := MapBuffer[step] and 1;
            if (MapBuffer[step] <= 32) then
            begin
              if OFF[MapBuffer[step]] > 1 then
              Begin
                if Header.flag=5 then
                  inc(step, OFF[MapBuffer[step]])
                else
                  inc(step, OFF1[MapBuffer[step]]);
              End
              else
                inc(step);
            end
            else
            begin
              error := true;
              break;
            end;
          end //flag=3
          else
          begin //flag =1
            nmpcellflag1 := @MapBuffer[step];
            inc(step, 12);
            if nmpcellflag1.n3 > 1000 then
              MapCellinfo.chFlag := 0
            else
              MapCellinfo.chFlag := 1;

          end;

        end; //for nw
      end; //for nh

      FreeMem(MapBuffer);

      FileClose(fHandle);
   //   if not error then
        Result := True;
    end; //004B57B1
  end; //004B57B1
end;

procedure TEnvirnoment.Initialize(nWidth, nHeight: Integer); //004B53FC
var
  nW, nH: Integer;
  MapCellInfo: pTMapCellinfo;
begin
  if (nWidth > 1) and (nHeight > 1) then
  begin
    if MapCellArray <> nil then
    begin
      for nW := 0 to m_nWidth - 1 do
      begin
        for nH := 0 to m_nHeight - 1 do
        begin
          MapCellInfo := @MapCellArray[nW * m_nHeight + nH];
          if MapCellInfo.ObjList <> nil then
          begin
            MapCellInfo.ObjList.Free;
            MapCellInfo.ObjList := nil;
          end;
        end;
      end;
      Setlength(MapCellArray, 0);
    end; //004B54AF
    m_nWidth := nWidth;
    m_nHeight := nHeight;
    SetLength(MapCellArray, m_nWidth * m_nHeight);
  end; //004B54DB
end;

//nFlag,boFlag,Monster,Item,Quest,boGrouped

function TEnvirnoment.CreateQuest(nFlag, nValue: Integer; s24, s28, s2C: string;
  boGrouped: Boolean): Boolean; //004B6C3C
var
  MapQuest: pTMapQuestInfo;
  MapMerchant: TMerchant;
begin
  Result := False;
  if nFlag < 0 then
    exit;
  New(MapQuest);
  MapQuest.nFlag := nFlag;
  if nValue > 1 then
    nValue := 1;
  MapQuest.nValue := nValue;
  if s24 = '*' then
    s24 := '';
  MapQuest.s08 := s24;
  if s28 = '*' then
    s28 := '';
  MapQuest.s0C := s28;
  if s2C = '*' then
    s2C := '';

  MapQuest.bo10 := boGrouped;
  MapMerchant := TMerchant.Create;
  MapMerchant.m_sMapName := '0';
  MapMerchant.m_nCurrX := 0;
  MapMerchant.m_nCurrY := 0;
  MapMerchant.m_sCharName := s2C;
  MapMerchant.m_nFlag := 0;
  MapMerchant.m_wAppr := 0;
  MapMerchant.m_sFilePath := 'MapQuest_def\';
  MapMerchant.m_boIsHide := True;
  MapMerchant.m_boIsQuest := False;

  UserEngine.QuestNPCList.Add(MapMerchant);
  MapQuest.NPC := MapMerchant;
  m_QuestList.Add(MapQuest);
  Result := True;
end;

function TEnvirnoment.GetXYObjCount(nX, nY: Integer): Integer; //004B5DB0
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  Result := 0;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then
  begin
    for I := 0 to MapCellInfo.ObjList.Count - 1 do
    begin
      OSObject := MapCellInfo.ObjList.Items[i];
      if OSObject = nil then
        continue;
      if OSObject.btType = OS_MOVINGOBJECT then
      begin
        BaseObject := TBaseObject(OSObject.CellObj);
        if BaseObject <> nil then
        begin
          if not BaseObject.m_boGhost and
            BaseObject.bo2B9 and
            not BaseObject.m_boDeath and
            not BaseObject.m_boFixedHideMode and
            not BaseObject.m_boObMode then
          begin
            Inc(Result);
          end;
        end;
      end;
    end;
  end;
end;
//004B2A6C

function TEnvirnoment.GetNextPosition(sx, sy, ndir, nFlag: Integer; var snx: Integer; var sny: Integer): Boolean;
begin
  snx := sx;
  sny := sy;
  case nDir of
    DR_UP:
      if sny > nFlag - 1 then
        Dec(sny, nFlag);
    DR_DOWN:
      if sny < (m_nHeight - nFlag) then
        Inc(sny, nFlag);
    DR_LEFT:
      if snx > nFlag - 1 then
        Dec(snx, nFlag);
    DR_RIGHT:
      if snx < (m_nWidth - nFlag) then
        Inc(snx, nFlag);
    DR_UPLEFT:
      begin
        if (snx > nFlag - 1) and (sny > nFlag - 1) then
        begin
          Dec(snx, nFlag);
          Dec(sny, nFlag);
        end;
      end;
    DR_UPRIGHT:
      begin //004B2B77
        if (snx > nFlag - 1) and (sny < (m_nHeight - nFlag)) then
        begin
          Inc(snx, nFlag);
          Dec(sny, nFlag);
        end;
      end;
    DR_DOWNLEFT:
      begin //004B2BAC
        if (snx < (m_nWidth - nFlag)) and (sny > nFlag - 1) then
        begin
          Dec(snx, nFlag);
          Inc(sny, nFlag);
        end;
      end;
    DR_DOWNRIGHT:
      begin
        if (snx < (m_nWidth - nFlag)) and (sny < (m_nHeight - nFlag)) then
        begin
          Inc(snx, nFlag);
          Inc(sny, nFlag);
        end;
      end;
  end;
  if (snx = sx) and (sny = sy) then
    Result := False
  else
    Result := True;

end;

function TEnvirnoment.CanSafeWalk(nX, nY: Integer): Boolean; //004B609C
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
begin
  Result := True;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then
  begin
    for I := MapCellInfo.ObjList.Count - 1 downto 0 do
    begin
      OSObject := MapCellInfo.ObjList.Items[i];
      if OSObject.btType = OS_EVENTOBJECT then
      begin
        if TEvent(OSObject.CellObj).m_nDamage > 0 then
          Result := False;
      end;
    end;
  end;
end;

function TEnvirnoment.ArroundDoorOpened(nX, nY: Integer): Boolean; //004B6B48
var
  I: Integer;
  Door: pTDoorInfo;
resourcestring
  sExceptionMsg = '[Exception] TEnvirnoment::ArroundDoorOpened ';
begin
  Result := True;
  try
    for I := 0 to m_DoorList.Count - 1 do
    begin
      Door := m_DoorList.Items[i];
      if (abs(Door.nX - nX) <= 1) and ((abs(Door.nY - nY) <= 1)) then
      begin
        if not Door.Status.boOpened then
        begin
          Result := False;
          break;
        end;
      end;
    end;
  except
    MainOutMessage(sExceptionMsg);
  end;
end;

function TEnvirnoment.GetMovingObject(nX, nY: Integer; boFlag: Boolean): Pointer; //004B5838
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  Result := nil;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then
  begin
    for I := 0 to MapCellInfo.ObjList.Count - 1 do
    begin
      OSObject := MapCellInfo.ObjList.Items[i];
      if OSObject = nil then
        continue;
      if OSObject.btType = OS_MOVINGOBJECT then
      begin
        BaseObject := TBaseObject(OSObject.CellObj);
        if ((BaseObject <> nil) and
          (not BaseObject.m_boGhost) and
          (BaseObject.bo2B9)) and
          ((not boFlag) or (not BaseObject.m_boDeath)) then
        begin

          Result := BaseObject;
          break;
        end;
      end;
    end;
  end;
end;
function TEnvirnoment.GetMovingObjectNotSelf(BaseSelf: TObject;nX, nY: Integer; boFlag: Boolean): Pointer; //004B5838
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  Result := nil;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then
  begin
    for I := 0 to MapCellInfo.ObjList.Count - 1 do
    begin
      OSObject := MapCellInfo.ObjList.Items[i];
      if OSObject = nil then
        continue;
      if OSObject.btType = OS_MOVINGOBJECT then
      begin
        BaseObject := TBaseObject(OSObject.CellObj);
        if (BaseObject <> nil) and
          (not BaseObject.m_boGhost) and
         (Baseobject<>BaseSelf) then
        begin

          Result := BaseObject;
          break;
        end;
      end;
    end;
  end;
end;
function TEnvirnoment.GetQuestNPC(BaseObject: TObject; sCharName, sStr: string; boFlag: Boolean): TObject; //004B6E4C
var
  I: Integer;
  MapQuestFlag: pTMapQuestInfo;
  nFlagValue: Integer;
  bo1D: Boolean;
begin
  Result := nil;
  for I := 0 to m_QuestList.Count - 1 do
  begin
    MapQuestFlag := m_QuestList.Items[i];
    nFlagValue := TBaseObject(BaseObject).GetQuestFalgStatus(MapQuestFlag.nFlag);
    if nFlagValue = MapQuestFlag.nValue then
    begin
      if (boFlag = MapQuestFlag.bo10) or (not boFlag) then
      begin
        bo1D := False;
        if (MapQuestFlag.s08 <> '') and (MapQuestFlag.s0C <> '') then
        begin
          if (MapQuestFlag.s08 = sCharName) and (MapQuestFlag.s0C = sStr) then
            bo1D := True;
        end;
        if (MapQuestFlag.s08 <> '') and (MapQuestFlag.s0C = '') then
        begin
          if (MapQuestFlag.s08 = sCharName) and (sStr = '') then
            bo1D := True;
        end;
        if (MapQuestFlag.s08 = '') and (MapQuestFlag.s0C <> '') then
        begin
          if (MapQuestFlag.s0C = sStr) then
            bo1D := True;
        end;
        if bo1D then
        begin
          Result := MapQuestFlag.NPC;
          break;
        end;
      end;
    end;
  end;
end;

function TEnvirnoment.GetItemEx(nX, nY: Integer;
  var nCount: Integer): Pointer; //004B5C10
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  Result := nil;
  nCount := 0;
  bo2C := False;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 0) then
  begin
    bo2C := True;
    if MapCellInfo.ObjList <> nil then
    begin
      for I := 0 to MapCellInfo.ObjList.Count - 1 do
      begin
        OSObject := MapCellInfo.ObjList.Items[i];
        if OSObject = nil then
          continue;
        if OSObject.btType = OS_ITEMOBJECT then
        begin
          Result := Pointer(OSObject.CellObj);
          Inc(nCount);
        end;
        if OSObject.btType = OS_GATEOBJECT then
        begin
          bo2C := False;
        end;
        if OSObject.btType = OS_MOVINGOBJECT then
        begin
          BaseObject := TBaseObject(OSObject.CellObj);
          if not BaseObject.m_boDeath then
            bo2C := False;
        end;
      end;
    end;
  end;

end;

function TEnvirnoment.GetDoor(nX, nY: Integer): pTDoorInfo; //004B6ACC
var
  I: Integer;
  Door: pTDoorInfo;
begin
  Result := nil;
  for I := 0 to m_DoorList.Count - 1 do
  begin
    Door := m_DoorList.Items[i];
    if (Door.nX = nX) and (Door.nY = nY) then
    begin
      Result := Door;
      exit;
    end;
  end;
end;

function TEnvirnoment.IsValidObject(nX, nY, nRage: Integer; BaseObject: TObject): Boolean; //004B5A3C
var
  nXX, nYY, I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
begin
  Result := False;
  for nXX := nX - nRage to nX + nRage do
  begin
    for nYY := nY - nRage to nY + nRage do
    begin
      if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then
      begin
        for I := 0 to MapCellInfo.ObjList.Count - 1 do
        begin
          OSObject := MapCellInfo.ObjList.Items[i];
          if OSObject.CellObj = BaseObject then
          begin
            Result := True;
            exit;
          end;
        end;
      end;
    end;
  end;
end;
procedure TEnvirnoment.clearMapBody;
var
  nX, nY,i: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin

  try
      for nX := 0 to m_nWidth-1 do
      begin
        for nY := 0 to m_nHeight-1 do
        begin
            if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then
            begin
              for I :=  MapCellInfo.ObjList.Count - 1 downto 0 do
              begin
                OSObject := MapCellInfo.ObjList.Items[i];
                if OSObject = nil then
                  continue;
                if OSObject.btType = OS_MOVINGOBJECT then
                begin
                  BaseObject := TBaseObject(OSObject.CellObj);
                  if BaseObject <> nil then
                  begin
                    if BaseObject.m_boDeath  then
                    begin
                       BaseObject.DisappearA;
                    end;
                  end;
                end;
              end;
            end;
        end;
      end;

  finally

  end;

end;
procedure TEnvirnoment.clearMapItem;
var
  nX, nY,i: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;

begin

  try
      for nX := 0 to m_nWidth-1 do
      begin
        for nY := 0 to m_nHeight-1 do
        begin
            if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then
            begin
              for I :=  MapCellInfo.ObjList.Count - 1 downto 0 do
              begin
                OSObject := MapCellInfo.ObjList.Items[i];
                if OSObject = nil then
                  continue;
                if OSObject.btType = OS_ITEMOBJECT then
                begin
                  MapCellInfo.ObjList.Delete(i);
                  DisPose(OSObject);
                end;
              end;
              if MapCellInfo.ObjList.Count =0 then
              Begin
                 MapCellInfo.ObjList.Free;
                 MapCellInfo.ObjList := nil;
              End;
            end;
        end;
      end;

  finally

  end;

end;
function TEnvirnoment.GetRangeBaseObject(nX, nY, nRage: Integer; boFlag: Boolean;
  BaseObjectList: TList): Integer; //004B59C0
var
  nXX, nYY: Integer;
begin
  for nXX := nX - nRage to nX + nRage do
  begin
    for nYY := nY - nRage to nY + nRage do
    begin
      GetBaseObjects(nXX, nYY, boFlag, BaseObjectList);
    end;
  end;
  Result := BaseObjectList.Count;
end;
//boFlag �Ƿ������������
//FALSE ������������
//TRUE  ��������������

function TEnvirnoment.GetBaseObjects(nX, nY: Integer; boFlag: Boolean;
  BaseObjectList: TList): Integer; //004B58F8
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then
  begin
    for I := 0 to MapCellInfo.ObjList.Count - 1 do
    begin
      OSObject := MapCellInfo.ObjList.Items[i];
      if OSObject = nil then
        continue;
      if OSObject.btType = OS_MOVINGOBJECT then
      begin
        BaseObject := TBaseObject(OSObject.CellObj);
        if BaseObject <> nil then
        begin
          if not BaseObject.m_boGhost and BaseObject.bo2B9 then
          begin
            if not boFlag or not BaseObject.m_boDeath then
              BaseObjectList.Add(BaseObject);
          end;
        end;
      end;
    end;
  end;
  Result := BaseObjectList.Count;
end;
function TEnvirnoment.GetEvent(nX, nY: Integer): TObject; //004B5D24
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
begin
  Result := nil;
  bo2C := False;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then
  begin
    for I := 0 to MapCellInfo.ObjList.Count - 1 do
    begin
      OSObject := MapCellInfo.ObjList.Items[i];
      if OSObject.btType = OS_EVENTOBJECT then
      begin
        Result := OSObject.CellObj;
      end;
    end;
  end;
end;

procedure TEnvirnoment.SetMapXYFlag(nX, nY: Integer; boFlag: Boolean); //004B5E8C
var
  MapCellInfo: pTMapCellinfo;
begin
  if GetMapCellInfo(nX, nY, MapCellInfo) then
  begin
    if boFlag then
      MapCellInfo.chFlag := 0
    else
      MapCellInfo.chFlag := 2;
  end;
end;

procedure TEnvirnoment.SetMapXYFlagx(nX, nY, nFlag: Integer); //004B5E8C
var
  MapCellInfo: pTMapCellinfo;
begin
  if GetMapCellInfo(nX, nY, MapCellInfo) then
  begin
    MapCellInfo.chFlag := nFlag;
  end;
end;


function TEnvirnoment.CanFly(nsX, nsY, ndX, ndY: integer): Boolean; //004B600C
var
  r28, r30: Real;
  n14, n18, n1C: Integer;
begin
  Result := True;
  r28 := (ndX - nsX) / 1.0E1;
  r30 := (ndY - ndY) / 1.0E1;
  n14 := 0;
  while (True) do
  begin
    n18 := ROUND(nsX + r28);
    n1C := ROUND(nsY + r30);
    if not CanWalk(n18, n1C, True) then
    begin
      Result := False;
      break;
    end;
    Inc(n14);
    if n14 >= 10 then
      break;
  end;
end;



function TEnvirnoment.GetXYHuman(nMapX, nMapY: Integer): Boolean;
var
  I: Integer;
  MapCellInfo: pTMapCellinfo;
  OSObject: pTOSObject;
  BaseObject: TBaseObject;
begin
  Result := False;
  if GetMapCellInfo(nMapX, nMapY, MapCellInfo) and (MapCellInfo.ObjList <> nil) then
  begin
    for I := 0 to MapCellInfo.ObjList.Count - 1 do
    begin
      OSObject := MapCellInfo.ObjList.Items[i];
      if OSObject = nil then
        continue;
      if OSObject.btType = OS_MOVINGOBJECT then
      begin
        BaseObject := TBaseObject(OSObject.CellObj);
        if BaseObject.m_btRaceServer = RC_PLAYOBJECT then
        begin
          Result := True;
          break;
        end;
      end;
    end;
  end;
end;

function TEnvirnoment.sub_4B5FC8(nX, nY: Integer): Boolean; //0x004B5FC8
var
  MapCellInfo: pTMapCellinfo;
begin
  Result := True;
  if GetMapCellInfo(nX, nY, MapCellInfo) and (MapCellInfo.chFlag = 2) then
    Result := False;
end;

function TEnvirnoment.GetEnvirInfo: string;
var
  sMsg: string;
begin
  sMsg := '��ͼ��:%s(%s) DAY:%s DARK:%s SAFE:%s FIGHT:%s FIGHT3:%s QUIZ:%s NORECONNECT:%s(%s) MUSIC:%s(%d) EXPRATE:%s(%f) PKWINLEVEL:%s(%d) PKLOSTLEVEL:%s(%d) PKWINEXP:%s(%d) PKLOSTEXP:%s(%d) DECHP:%s(%d/%d) INCHP:%s(%d/%d)';
  sMsg := sMsg + ' DECGAMEGOLD:%s(%d/%d) INCGAMEGOLD:%s(%d/%d) INCGAMEPOINT:%s(%d/%d) RUNHUMAN:%s RUNMON:%s NEEDHOLE:%s NORECALL:%s NOGUILDRECALL:%s NODEARRECALL:%s NOMASTERRECALL:%s NODRUG:%s MINE:%s NOPOSITIONMOVE:%s';
  Result := format(sMsg, [sMapName,
    sMapDesc,
      BoolToCStr(m_boDAY),
      BoolToCStr(m_boDARK),
      BoolToCStr(m_boSAFE),
      BoolToCStr(m_boFightZone),
      BoolToCStr(m_boFight3Zone),
      BoolToCStr(m_boQUIZ),
      BoolToCStr(m_boNORECONNECT), sNoReconnectMap,
      BoolToCStr(m_boMUSIC), m_nMUSICID,
      BoolToCStr(m_boEXPRATE), m_nEXPRATE / 100,
      BoolToCStr(m_boPKWINLEVEL), m_nPKWINLEVEL,
      BoolToCStr(m_boPKLOSTLEVEL), m_nPKLOSTLEVEL,
      BoolToCStr(m_boPKWINEXP), m_nPKWINEXP,
      BoolToCStr(m_boPKLOSTEXP), m_nPKLOSTEXP,
      BoolToCStr(m_boDECHP), m_nDECHPTIME, m_nDECHPPOINT,
      BoolToCStr(m_boINCHP), m_nINCHPTIME, m_nINCHPPOINT,
      BoolToCStr(m_boDECGAMEGOLD), m_nDECGAMEGOLDTIME, m_nDECGAMEGOLD,
      BoolToCStr(m_boINCGAMEGOLD), m_nINCGAMEGOLDTIME, m_nINCGAMEGOLD,
      BoolToCStr(m_boINCGAMEPOINT), m_nINCGAMEPOINTTIME, m_nINCGAMEPOINT,
      BoolToCStr(m_boRUNHUMAN),
      BoolToCStr(m_boRUNMON),
      BoolToCStr(m_boNEEDHOLE),
      BoolToCStr(m_boNORECALL),
      BoolToCStr(m_boNOGUILDRECALL),
      BoolToCStr(m_boNODEARRECALL),
      BoolToCStr(m_boNOMASTERRECALL),
      BoolToCStr(m_boNODRUG),
      BoolToCStr(m_boMINE),
      BoolToCStr(m_boNOPOSITIONMOVE)
      ]);
end;

procedure TEnvirnoment.AddObject(nType: Integer);
begin
  case nType of
    0: Inc(m_nHumCount);
    1: Inc(m_nMonCount);
  end;
end;

procedure TEnvirnoment.DelObjectCount(BaseObject: TObject);
var
  btRaceServer: Byte;
begin
  btRaceServer := TBaseObject(BaseObject).m_btRaceServer;
  if btRaceServer = RC_PLAYOBJECT then
    dec(m_nHumCount);
  if btRaceServer >= RC_ANIMAL then
    dec(m_nMonCount);
end;

procedure TMapManager.Run;
begin

end;

end.
