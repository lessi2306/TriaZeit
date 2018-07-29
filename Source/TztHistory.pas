unit TztHistory;

interface

const
  cnVersionsNummer = '5.4';  // Konstanten-Bezeichnung gleich f�r Tria
  cnVersionsJahr   = '2017'; // nur f�r InfoDlg

implementation

(******************************************************************************)
(*        History                                                             *)
(******************************************************************************)
{

13.05.2003 - Version 1.0 Released

02.07.2003:
TztAllg: in SortString function Format eingef�hrt 

15.07.2003:
TztInfoDlg:  Haftungsklausel ge�ndert

15.07.2003 - Version 1.1 Released


################################################################################
Version 1.2:
================================================================================
06.10.2003: TztAllg: TztColl.SortString korrigiert (FZeit=String, kein Integer)

13.10.2003: - Version 1.2 auf Homepage (mit Tria 1.9)
--------------------------------------------------------------------------------


################################################################################
Version 1.3:
================================================================================
02.11.03:
TztAllgDlg: Options in Save- und OpenDialoge korrigiert
alle:       mtError durch mtWarning ersetzt
TztMain:    Editiermode nicht mit ESC Abbrechen, nur �nderungen r�ckg�ngig
            Trennung EditierMode und ZeitnameMode entfernt, alle Buttons sind
            immer enabled.
            Menu Bearbeiten, Ansicht (Sortieren/Vergr��ern) und
            Optionen (Backup,SofortSpeichern) hinzugef�gt
            ToolButtons Editieren und Zeitnahme entfernt,
            Gr��er/Kleiner erg�nzt

TztAllg:    TztObj.Create - FSnr:='0000' statt CnSnrInitWert
            TztObj SetSnr/Zeit: nur bei �nderung neu Sortieren
            TztColl.TztAktuellSpeichern - Backup Option erg�nzt
TztAllgDlg: durch Unit TztDat ersetzt StartDialog entfernt

TztDat:     ofPathMustExist erg�nzt in SaveDialog
            DateiNeu:  Datei nicht speichern

22.12.2003: - Version 1.3 auf Homepage (mit Tria 2.2)
--------------------------------------------------------------------------------


################################################################################
Version 2.0:
================================================================================
15.02.04:   Windows XP Design
            Online, Kontextsensitive Hilfe

18.02.2004: - Version 2.0 auf Homepage (mit Tria 2004 - 1.0)
--------------------------------------------------------------------------------


################################################################################
Version 2.1:
================================================================================
28.03.04:  in TztDat-DateiNeu  function ExpandFileName benutz
           (hierf�r noch kein neues Release notwendig)

01.06.04:  in TztMain: Ansicht-Sortiermodes-Checked-Status korrigiert
           in TztMain: SofortSpeichernAction.Checked initialisiert
           in TztInfoDlg Web und Mail als Link
           in TztAllg: Add als parameter in TztObj.Create erg�nzt (ohne funktion)
           in TztMain: in UhrzeitTimerTick TztBufColl.ClearIndex(0) vor
           TztAktuellSpeichern, damit TztDatModified false gesetzt wird

02.06.2004: - Version 2.1 auf Homepage (mit Tria 2004 - 1.2)
--------------------------------------------------------------------------------


################################################################################
Version 2.2:
================================================================================
27.02.05:  in TztMain  Unterstrich in AendBtn von n nach e ge�ndert (war doppel)

27.02.05: - Version 2.2 erzeugt
11.03.05: - Version 2.2 mit XP Manifest compiliert,
            damit ist externe Manifest-Datei nicht mehr n�tig
13.04.05: - TztInfoDlg: Email-Adresse entfernt, CopyRight angepa�t
25.04.05: - TztAllg: cnBufferMax van 16 nach 10
--------------------------------------------------------------------------------


################################################################################
Version 2.3:
================================================================================
20.05.05:  Text in TztInfoDlg ge�ndert
--------------------------------------------------------------------------------


################################################################################
Version 3.0:
================================================================================
14.02.06: mit BDS 2006 compiliert

TztMain:
- ToolbuttonRand enfernt
- ActionMainMenuBar.PersistentHotKeys := true: in Create und in IdleHandler,
  weil dies nach Verwendung automatisch zur�ckgesetzt wird (Delphi Fehler?)
  Muss gesetzt bleiben, sonst wird '&' in Dateiname nicht richtig angezeigt.

TztInfoDlg:
- CopyRight bis 2006
- TMeno durch TLabel ersetzt, weil Text markiert und gel�scht werden konnte.

AllgFunc, etc. :
- function ErsetzeEinfachUnd eingef�hrt um '&' in MessageDlg/MruListe richtig
  anzuzeigen (Einfach '&' wird als Unterstrich angezeigt).
- Function TriaMessage als Ersatz f�r MessageDlg mit ErsetzeEinfachUnd

TztDat:
- ValidZeithhmmss durch UhrzeitWertSek ersetzt (Vereinheitlichung)

TztConfig:
- Configuration in Ini-Datei ablegen, �hnlich TriaConfig
  Sortiermode in Ini
  Default Sortiermode von ZeitAb nach ZeitAuf

TztDrucken:
- neu: Druckfunktion der Eintr�ge

TztOptDlg, TztMain:
- neue Optionen:
    Start mit letztbenutzte Datei
    Zeit in Zehntelsek.
    Stoppuhr

--------------------------------------------------------------------------------
14.4.2006: Released
--------------------------------------------------------------------------------


################################################################################
Version 3.1:
================================================================================
TztMain:
- SetFocus SnrEdit in Start- und Stop-ActionExecute
- DefaultExt ohne '*.'
- In Editmode nicht neu sortiren (smFestsortiert)
- Editmode: bei Enter ==> n�chste Zeile fokussieren
            TAB bleibt im Grid, nicht zum zeitnahme-modus

TztUpdDlg
- Neu: Internet Update

TztConfig
- Ini-datei in C:\Dokumente und einstellungen\user\Anwendungsdaten\Tria, weil
  hier keine Administrator-Rechte zum Erstellen/Schreiben n�tig sind
- Exceptions beim Speichern abfangen, damit das Programm beendet wird

--------------------------------------------------------------------------------
07.05.2006: Released
--------------------------------------------------------------------------------


################################################################################
Version 3.2:
================================================================================
TztMain:
- Men�Items MruDatei 1/2 - visible false gesetzt im design-modus, 3/4 waren Ok
TztMain/TztUpdDlg:
- Close von InternetUpdate nach UpdateActionExecute
TztAllg:
- TztAktuellSpeichern: bei Fehler wird SofortSpeichern zur�ckgesetzt und nicht
  Programm beendet
TztOptDlg:
- in OkButtonClick wird beim Setzen von SofortSpeichern vorher Datei erstellt,
  weil Datei vorhanden sein muss.
TztDat:
- in DatNeu wird bei SofortSpeichern Datei gespeichert, weil Datei vorhanden
  sein muss

--------------------------------------------------------------------------------
29.06.2006: Released
--------------------------------------------------------------------------------


################################################################################
Version 3.3:
================================================================================
- f�r Windows-Vista mit neue HTML-Help-version compiliert (wie Tria 2006-1.5)

- TztMain:
  Timermode in Create initialisiert: SetzeTimerModus(zmUhrZeit)

--------------------------------------------------------------------------------
28.03.2007: Released
--------------------------------------------------------------------------------


################################################################################
Version 4.0:
================================================================================

AllgFunc:
- TriaMessage: Position zentiert
- UhrzeitStr basiert auf 1/100 Sek statt 1/10

AllgConst,....
- ZeitFormat statt DecZeiten

-
TztConfig,TztMain:
- Position := poDesktopCenter in TztMain und poDesigned in TztConfig

VistaFix eingef�hrt

TztUpdDlg,TztOptDlg:
- DisableButtons eingef�hrt um Doppelklicks zu filtern

TztMain:
- TTztHauptDlg.FormPaint Alte StopPaint wiederherstellen statt immer auf false
  Damit wird flikkern beim Laden verhindert
- nach dem Start beim Drucken von "�ndern" steht Snr manchmal zu weit links.
  In TztGridPaint auch bei emNone GridSnrEdit,GridZeitEdit neu berechnen
- Zus�tzliche Spalte mit Zeilennr.

TztDat:
- kein Eintrag in leerer Datei speichern
- Daten wie sortiert speichern

AllgComp:
- TTriaGrid abgeleitet von TCustomDrawGrid statt TDrawGrid
  Nicht benutzte properties entfernt
- TTriaCustomMaskEdit neu als Basis f�r alle MaskEdits
- ValidateEdit als fuction statt procedure, zu verwenden in allen Dlg in EigabeOk,
  (weil Validate bei Enter nicht automatisch ausgef�hrt wird)
- FOrgText, AendereText, GetText, SetText neu, damit in ValidateEdit
  auch �nderungen erkannt werden, die in Change durchgef�hrt werden
- MessageBeep in ValidateError entfernt
- LeerValid entfernt (wird nur bei Liga MschGrAnm/Start benutzt)
- ClearText enfernt
- TZeitEdit.FLeerZulassen entfernt, immer zulassen (true in Tria, false in TriaZeit)
  
TztOptDlg,TztConfig,TztUpdDlg,AllgConst:
- Automatische Update-Pr�fung als neue Option (max 1x t�glich)
- Darstellung in Hundertstel
- Automatisch Speichern 0,1 - 99,9 Min

AllgFunc:
- TryStrToInt durch TryDecStrToInt ersetzt

TztAbglDlg:
- neu: Snr abgleichen

--------------------------------------------------------------------------------
01.03.2009: Released
--------------------------------------------------------------------------------


################################################################################
Version 4.1:
================================================================================

TztUpdDlg:
- InternetUpdate: StatusBarUpdate vor ShowModal

TztMain:
- UhrzeitTimerTick: Konflikt bei gleichzeitiger Zugriff wie in Tria l�sen
- CommandHeader, CommandTrailer eingef�hrt
- MruListe max 8 statt 4
- SetzeTimerModus: Hints f�r ZeitnahmeBtn korrigiert (F3,4,5)
- UhrzeitTimerTick: TrzDatModified gesetzt wenn Daten in TztGrid �bernommen werden.
- ZeitnahmeActionExecute: TrzDatModified nicht setzen wenn Daten in TztBuffColl �bernommen
- FormCreate und FormDestroy entfernt, Funktion in Create/Destroy �bernommen
- Initialisiert und Neustart entfernt, Initialisierung am Ende von Create statt
  in Idle Event Handler. Nur Focus in OnShow Event setzen.
  Timer und IdleHandler erst am Ende von Create enabled.
- Damit auch Fehler bei fehlender Hilfe-Datei korrigiert
- neue var: HelpDateiVerfuegbar, damit alle Hilfe-Funktionen disabled werden k�nnen
- neu: SetzeFocus statt RestoreFocus, auch ColEditMode bleibt erhalten
- bei Zeitnahme bleibt alter Focus erhalten statt grunds�tzlich SnrEdit.
  Kann benutz werden wenn Snr grunds�tzlich nach Zeitnahme eingegeben wird,
  deshalb keine spezielle Option daf�r notwendig. Dies ist auch verwirrend,
  wegen Funktion Eingabe-Taste (Zeitnahme oder �ndern?)

TztDat:
- DateiNeu - GetSpecialFolder(CSIDL_DESKTOPDIRECTORY), statt Programmdir,
             nur wenn vorher keine Datei geladen war
  DateiNeu - SetCurrentDirectory erg�nzt

TztOptDlg:
- AutospeichernInterval in Sek statt 1/10 Min, von 1 - 99 Sek.
  Min 1 Sek statt 6 Sek wegen Live Zeiterfassung
- neue Option: Beep bei Zeitnahme
  Neuer TAB Zeitnahme, mit StoppUhrMode und Beep

TztConfig, AllgConst, TztMain:
- Zeitnahme-Modus und StartUhrzeit in Ini, statt StoppUhr, damit bei Neustart in Run-Modus
  die Uhr weiter lauft.

--------------------------------------------------------------------------------
10.11.2009: Released
--------------------------------------------------------------------------------


################################################################################
Version 4.2:
================================================================================

TztMain:
- TztGridGetColText: Fehlerkorr.: LeerZeit wird als '' statt '-' gespeichert
- TztGridSelectCell: auf fehlender Zeit pr�fen
- SetzeButtons: auch TztGrid enabled/disable, damit �ber Click in EditMode unm�glich

TztDat:
- DateiLesen: bei statt auf Zeit=-1 auf ZeitFormat pr�fen, Leerzeit zulassen

AllgComp
- SetzeColEditMode statt SetColEditMode mit zuk�nftige Col,Row
  Diese wird OnSelectCell Eventhandler gepr�ft um bei Zeilen- oder Spaltewechsel
  in EditMode auf leeres Zeitfeld pr�fen zu k�nnen

--------------------------------------------------------------------------------
19.03.2010: Released
--------------------------------------------------------------------------------


################################################################################
Version 4.3:
================================================================================

TztDat:
- Speichern: nur speichern wenn Zeit <> Zeitinitwert

--------------------------------------------------------------------------------
28.03.2010: 4.3 Released
--------------------------------------------------------------------------------


################################################################################
Version 4.4:
================================================================================

AllgFunc:
- function AddLeadZero,RemLeadZero wieder eingef�hrt, weil benutzt f�r TriaZeit

TztDat,TztMain:
- FileOpenDialog1,FileSaveDialog1 f�r Vista erg�nzt (Neu in Delphi XE (2011))
- OpenFileDialog, SaveFileDialog angepasst

Anpassung an Delphi XE (2011):
Korrekturen f�r Delphi 2006 entfernt:
- AllgConst, etc.: DialogNeu entfernt, Korrektur f�r Delphi XE nicht mehr ben�tigt
- VistaFix: VistaAltFix, FileDialog-function entfernt
- TriaMain: D6OnHelpFix, HideAppFormTaskBarButton,CreateParams,WMSyscommand,WMActivate entfernt

TztAbglDlg:
- InitAbglColl: Abgleich verbessert
  vertauschte Snr besser erkennen: 2-fach und 3-fach �berholungen
  Differenz in Zahl der Snr- und Tzt-Eintr�ge ber�cksichtigen

TztDat:
- TztByteDatei (file of Byte): BlockWrite in SchreibeZeile funktioniert bei
  Delphi XE nicht mehr richtig (immer 2 Bytes geschrieben)
  Ersetzt durch lokale TztDatei (Textfile) (auch beim Lesen) und verwendung von WriteLn,
  function SchreibeZeile entfernt

--------------------------------------------------------------------------------
09.07.2012: 4.4 Released
--------------------------------------------------------------------------------


################################################################################
Version 4.5:
================================================================================
AllgComp:
- TTriaGrid:
  - neu EditierMode, AktionsSpalte,
  - OnMouseWheel event und DoMouseWheel public; benutzt wenn TztHauptDlg Edits fokussiert
  - neu: NachUnten; benutz f�r Enter-Taste in EditierMode, ggf. unten neue Zeile anh�ngen
  - NachRechts,Links: immer n�chste Zeile unten, ggf. neue Zeile anh�ngen
  - neu: ColEditBreite
  - ColEditMode schreibbar
  - neu: TStartZeitEdit: Startzeit in StoppUhrmodus editierbar
  - SetColEditsPos ge�ndert: Edit in der Mitte zentriert
  - DrawCell entfernt, Rahmen in Paint
  - SelectCell entfernt, Funktionen in OnSelectCell
  - neu: GetColEditsPos, gemeinsam f�r SetColEditPos und TTztHauptDlg.CustomAlignPosition
  - InvalidateZelle, InvalidateAlles entfernt, immer InvalidateGrid benutzen
  - FocusZelle: nur FocusCell aufrufen, nicht zus�tzlich mit SelectCell pr�fen
  - KeyPress: bei verlassen der Zelle immer ColEditMode aus, Enter nach n�chste Zeile
    statt SwitchColMode: Reset-, SetColEditMode

- TCustomMaskEdit:
  - SetText: Modified:= false erg�nzt,  wird in inherited SetText nicht false
    wenn ge�nderte Text gleich neuer Text

- TZeitEdit:
  - IstLeer erg�nzt f�r Maskzeichen '\' vor ':', damit unabh�ngig von L�ndereinstellungen

AllgConst:
- TZeitGleich = (zgGleichOk,zgGleichNok);
- TTimerModus: neu zmStart

AllgFunc:
- ZeitFormatOk: DecTrennzeichen erg�nzt

TztOptDlg:
- das Verhindern der Erfassung von identischen Zeiten nicht l�nger fest vorgegeben
  sondern als Option unter Extras einstellbar.
  Als Vorgabe gleiche Zeiten zulassen. Beim Laden der Ini-Datei die Verhinderung
  als Default einstellen wegen Kompatibilit�t

TztAbglDlg:
- Tabelle: 7 statt 9 Spalten, AktionsSpalte mit Button-Funktion f�r Abgleich
- SnrDateiLesen korrigiert:
  - Exception bei Snr mit weniger als 4 Ziffern (Min statt Max)
  - Leere Datei als Leer gelmeldet statt ung�ltig
  - Dateiname von SnrDatei statt ZeitDatei in Fehlermeldung
- SetzeButtons korrigiert f�r leeres Item am Ende von TztColl
- AbglGridDblClick: Setze ColEditMode
- neu: AbglGridMouseDown,AbglGridMouseUp: Zeile Abgleichen mit AktionsSpalte
- function Farbe durch getrennt f�r Hintergrund und AktionsSymbole
- CMDialogKey: VK_TAB in Edits abfangen f�r TriaGrid.KeyDown
- neu: Abgleichen, einzelne Zeile abgleichen nach Tastendruck
- TztCollLesen: LeerZeile am Ende ignorieren
- TAbglObj.SetzeAktion: Item neu sorieren, kann beim entfernen rausfallen
- AbglGridSelectCell: nur in ColEditMode pr�fen, wenn Ok ausschalten
- AbglGridDrawCell: AktionsSpalte mit Buttons zeichnen
- OnShow: StatusGB use SetWindowLong damit HelpContext funktioniert

TztAllg:
- Text- und Hintergrundfarbe f�r Nr.-Spalte grau, Nr-�berschrift erg�nzt.
- neu: GleichZeitInitWert, TztInitWert
- TTztColl.AddItem: leeres Item am Ende anh�ngen, wenn noch keine Leerzeile, sonst keine Aktion.
  Wenn nicht in FestSortMode (ZeitnahmeModus) am Ende anh�ngen, FestSortIndex ohne Bedeutung.
  In FestSortMode (EditierModus) kann ColEditMode gesetzt sein (F5-Taste).
  An vorletzte Zeile einf�gen wenn letzte Zeile leer, sonst letzte Zeile.
- neu: TTztColl.InsertItem,ClearIndex: FestSortIndex neu definieren
- TTztColl.SortString: wenn nicht FestSortIndex leerZeile am Ende

TztConfig:
- neue function SetzeZeitFormat nach Einlesen von ZeitFormat,TrennZeichen benutzen

TztDat:
- DateiLesen:
  - Leere Datei erkennen und melden
  - ZeitFormat,TrennZeichen zun�chst puffern, erst wenn Laden Ok function SetzeZeitFormat aufrufen

TztMain:
- ZeitInitWert: Ergebnis mit DecTrennZeichen statt fest '.'
- ZeitEdit in ZeitDummyEdit umbenannt, neu ZeitEdit-TStartZeitEdit. In StoppMdus
  ist StartZeit editierbar 0:00:00-23:59:59
- neu: TrennPanel zwischen Edits und Grid
- neu: CMDialogKey: VK_TAB in Edits abfangen f�r TriaGrid.KeyDown
- ResetEditierMode und SetzeEditierMode ersetzen ResetEditMode. In EditierMode
  eine Zelle im Grid in Focus, sonnst ganze Zeile Hellblau. In EditierMode wird
  Ziffer-Eingabe sofort eingetragen, dabei zuerst ColEditMode setzen, wobei ColEdit
  in Front. Nach jede Eingabe ColEditMode abschalten (Grid in front) und im Zelle
  Text von TztColl anzeigen.
  Immer eine Leerzeile unten
  In EditierMode Sortieren ausgeschaltet (FestSortIndex)
- SetzeTimerModus: zmStart erg�nzt, gesetzt mit Button,
  speichert StartUhrzeit und wechselt automatisch in zmRum
  ZeitEdit in zmStop editierbar, sonst ReadOnly
- UpdateStatusBar: letzte Leerzeile nicht mitz�hlen
- SetzeZeitFormat: zus�tzlich zum ZeitFormat und TrennZeichen:
  InitEditMask f�r ZeitEdits, TztColl Zeitwert anpassen, Layout/FontSize anpassen
- StartActionExecute: F3-Taste landet hier, EditierMode und ColEditMode beibehalten
- SetzeButtons: TztGrid nicht disabeln, weil Focus verloren geht
- F5 Taste in EditierMode und ColEditMode: Focus bleibt, kein R�ckkehr zum Zeitnahme-Mod
- CreateMutex(nil, False, 'TriaZeitMutexName'); eingef�hrt um beim n�chsten Update
  Setup abzubrechen wenn tria ausgef�hrt wird

--------------------------------------------------------------------------------
07.04.2014: 4.5 Released
--------------------------------------------------------------------------------

################################################################################
Version 5.0:
================================================================================

von Delphi XE auf XE2 umgestellt

Setup:
- neue Version Inno Setup: 5.5.5

Hilfe:
- TriaZeit.ali korrigiert.
  Hilfe-Button in Dialogen springt jetzt an die richtige Stelle in der Online-Hilfe

AllgConst:
- SpalteZahl,RndCheckZahl,SpalteTln neu eingef�hrt
- Kopierdatei neu eingef�hrt, in INI speichern und voreinstellen
- StartlisteDatei neu, in INI speichern und voreinstellen
- RpDefine aus uses entfernt, weil nicht ben�tigt

AllgObj:
- function TTriaSortList.Find: List^() durch Items[] ersetzt (f�r XE2)

AllgComp:
- TTriaGrid.MouseDown: bei EinzelClick in non-ColEdit-Spalte immer FocusCell,
  auch in EditierMode, damit neue Zeile selektiert wird

AllgFunc:
- System.UITypes in uses erg�nzt f�r XE2
- function ZeitInitWert und GleichZeitInitWert neu
- function ZeitFormatOk: Format UND Inhalt pr�fen f�r Abbruch von Einlesen,
                         Initwert bleibt zul�ssig

TztAllg:
- Windows in uses erg�nzt (XE2)
- TTztObj: neu: function InitWert ersetzt allgemeine funktion TztInitWert
- TtztColl: neu: SnrSortList um schnell Anzahl Zeitnahmen zu  berechnen
- SnrNameListe,StartlisteDateiName neu f�r Startliste
- MinBreiteArray f�r verschiedene Spaltenformate

TztDat:
- DateiKopieren: letzte Zieldatei wird voreingestellt.
  In var KopierDatei gespeichert und in Ini gesichert.
- neu: StartlisteDateiLaden

TztMain:
- SetzeZeitFormat: TztDatModified:=true entfernt, falsch f�r TztConfig und TztDat
  wird nur f�r TztOptDlg ben�tigt und dort extra gesetzt
  bei laden einer Datei mit andererem Zeitformat wird TztDatModified gesetzt
- Tastatur-Hook f�r Funktionstaste F5, damit F5 immer funktioniert, auch wenn ein
  Dialog ge�ffnet ist. Wichtig f�r remote Zeitnahme.
  Einzige Bedingung: TriaZeit-Fenster muss das aktive Fenster sein
- Optional Spalte mit Namen aus Startliste-Datei, Warnung wenn Snr unbekannt
- Optional Spalte mit Anzahl Zeitnahmen, Warnung bei �berschreitung Limit

TztOptDlg:
- neue TAB: Ansicht

TztConfig:
- Classes in uses (XE2)
- LadeKonfiguration: bei WindowState = wsMaximized/Minimized wsNormal mit
  Min-Groesse einstellen
  UpdateLayout nachdem alle relevante Werte festgelegt sind

TztStrtLst:
- Neu zur Anzeige der aus Tria importierten Startliste.

hh, hh_funcs:
- korrigiert f�r Delphi XE2:
  - $warn SYMBOL_PLATFORM off verursacht offenbar Absturz IDE,
    sicherheitshalber alle Compiler-Dirs auskommentiert
  - function HelpHook: Longint durch Nativeint ersetzt

--------------------------------------------------------------------------------
09.02.2015: 5.0 Released
--------------------------------------------------------------------------------

################################################################################
Version 5.1:
================================================================================

TztMain:
- ZeitnahmeActionExecute: Beep bei Anzahl- oder Name-Fehler

--------------------------------------------------------------------------------
09.02.2015: 5.1 Released
--------------------------------------------------------------------------------


################################################################################
Version 5.2:
================================================================================

AllgFunc, TztDat:
- function ZeitFormatOk: '.' und ',' als Trennzeichen zulassen (Anpassung an Tria)

TztUpdDlg:
- Fehlerkorrektur: LHandler: TIdSSLIOHandlerSocketOpenSSL erg�nzt, sonst
  Exception in IdHTTP.Get - seit Umstellung von www.selten.de auf SSL / HTTPS
  wie in Tria

AllgConst,AllgFunc,AllgObj,AllgComp:
- an Tria angepasst

--------------------------------------------------------------------------------
22.02.2016: 5.2 Released
--------------------------------------------------------------------------------


################################################################################
Version 5.3:
================================================================================

AllgComp:
- TTriaGrid.KeyDown:
  Keys: $60..$69: f�r NumPad 0..9 erg�nzt
  GetCharFromVirtualKey(..) ersetzt Char(..) damit $60..$69 Ziffern richtig umgewandelt werden

TztUpdDlg:
- PadFileLesen:  bei Get-Exception IOHandler := nil;
  ohne SSL-Handler probieren, falls zuk�nftig kein SSL auf Website


--------------------------------------------------------------------------------
09.04.2016: 5.3 Released
--------------------------------------------------------------------------------


################################################################################
Version 5.4:
================================================================================

TztUpdDlg:
- auf Homepage werden xml- und exe-dateien nicht mehr auf https umgeschaltet,
  weil Tria-Zugriff nicht funktioniert. Veraltetes protokoll wird nach
  1&1-Vertrags�nderung nicht mehr unterst�tzt.
  IdSSLOpenSSL nicht mehr benutzt, zur�ck nach altem Zustand.
- TriaMessage auf DialogForm zentriert

AllgComp:
- TTriaMaskEdit.Change: UpDown-Limits werden erst bei Exit in Validate gepr�ft,
  damit keine Fehlermeldung bei ung�ltiger Zwischenstand w�hrend Eingabe
- TTriaUpDown.Click: FEdit.ValidateEdit erg�nzt, weil bei Click Validate nicht
  automatisch ausgef�hrt wird.
- TTriaCustomMaskEdit:
  ZahlFormat : TZahlFormat erg�nzt f�r Pr�fung ohne EditMask
- TTriaGrid.KeyDown: �berschreiben und BlockCursor nur wenn IsMasked,
  Bei VK_DELETE: Text := '' statt '0'
- TTriaGrid.SetColEditMode: BlockCursor nur wenn IsMasked
- TTriaGrid.ColEditBreite: anpassung f�r RfidModus
- TTriaCustomMaskEdit.KeyPress: pr�fen auf zfDez und zfHex wenn not IsMasked
- TTriaMaskEdit.KorrigiereCursor: �ndern nur f�r wenn IsMasked
- TTriaMaskEdit.Change: �ndern nur f�r wenn IsMasked,
  UpDown-Limits nicht mehr pr�fen, sondern in Validate
- TTriaMaskEdit.Create: TextAlt := '' statt '0'
- TTriaUpDown.Click: FEdit.ValidateEdit erg�nzen, weil dies bei Exit aus FEdit
  hier nicht automatisch ausgef�hrt wird

AllgConst:
- TTrzDateiFormat: neu fzSonstig f�r fleibles Format,
  neu  TZahlFormat = (zfKein,zfDez,zfHex) f�r rfid-Pr�fung
- Rfid - Konstanten

AllgFunc:
- TriaMessage wird mit CreateMessageDialog im Form zentriert und mit Form als
  zus�tzlicher Parameter
- zus�tzliche Rfid-Pr�fungen (RfidCodeValid, etc.)
- AddLeadZero: auch bei LeerString

TztAllg:
- TTztColl TztBuffColl nicht sortieren (smNichtSortiert)
- MinBreiteArray erg�nzt f�r Snr/Rfid
- TTztObj.SetSnrRfid statt SetSnr
- TTztObj.InitWert: erg�nzt f�r Rfid (= '')

TztConfig:
- LadeKonfiguration: Layout auf Hauptbildschirm f�r MultiScreen angepasst
  SetBounds benutzt damit Align nur 1x aufgerufen wird
- Rfid Werte erg�nzt

TztDat:
- UpdateLayout statt SetzeFontSizeMax wegen Zeitformat
- DateiNeu:  UpdateLayout statt SetzeFontSizeMax // wegen Zeitformat
- DateiLesen: erg�nzt f�r Rfid-Code
  Abfragen wenn ZeitFormatBuf <> ZeitFormat
  Bei Rfid-Fehler abfragen ob abgebrochen werden soll, nicht grunds�tzlich abbrechen
  Genauere Fehlermeldung
- Fehlermeldungen Startliste korrigiert

TztDruck:
- Drucken: kein Druck wenn ItemCount=1 und Initwert
  InitWert am Ende nicht mitdrucken
- function TztText: f�r RfidCode erg�nzt, mindestens 4 Zeichen

TztOptDlg:
- TriaMessage auf DialogForm zentriert
- Cancel false gesetzt f�r CancelButton, damit das Fendte nicht mit Esc geschlossen wird
- ZeitNahmeGB f�r Rfid/Snr-Einstellungen, wie Tria
- OkButtonClick: ValidateEdit f�r Edits erg�nzt, weil Validate nicht automatisch
  ausgef�hrt wird bei ENTER-Taste

TztStrtLst:
- Liste zentriert

TztMain:
- f�r Multiscreen mit mehreren Monitoren angepasst
- poScreenCenter statt poDesktopCenter , wird bei mehreren Monitoren �ber alle zentriert
- Screen.WorkAreaHeight/Width (=Hauptbildschirm) durch Self.Monitor.WorkAreaRect.Height/Width
  (= BenutzerBildschirm) ersetzt
- Maus kann f�r remote Zeitnahme �ber dem Button "Zeitnahme" eingesperrt werden.
- Zeitnahme in EditierMode:
    nur bei remote Zeitnahme (mit F5 oder gesperrtem MausKlick) EditMode und ColEditMode
    nicht �ndern und Zeit in der ersten Zeile ohne Zeit eintragen.
    Nur wenn keine fehlende Zeit vorhanden oder g�ltige Snr oben eingetragen, neuer Eintrag erstellen
    und am Ende (unsortiert) hinzuf�gen.
    Bei sonstiger Zeitnahme (Alt-Z) oder Men�klick wie bisher EditierMode zur�cksetzen
    und neuer Zeit-Eintrag erstellen und entsprechend Sortierung einf�gen oder anh�ngen.
- Zeitnahme in Zeitnahme Modus:
    wie bisher neuer Zeit-Eintrag erstellen und entsprechend Sortierung einf�gen oder anh�ngen.
- TztGridKeyPress: EditierMode nicht mehr mit ESC ausschalten, wegen Remote Zeitnahme
- Vcl.AppEvnts in uses erg�nzen
- MausSperrenAction neue Aktion
- neuer Prozedur AppActivate: nach DeActivate/Activate Maus-Sperrung ggf. wieder herstellen
- MausFixEdit neu: Info �ber Maus-Freigabe
- neue Funktionen: TztGridSnrText,-Anzahl,-Name
- procedure AlignControls mit Mausposition Fixieren
- UpdateLayout: AlignControls(nil,ARect) aufrufen,
  SnrRfidEdit.EditMask := '', damit kein blauer BlockCursor
- AlignControls: Form Align wenn Acontrol=nil. Hier feste Werte nur 1x berechnen
- SetzeFontSizeMax f�r ClientRect berechnen statt Width/Height und f�r alle Fonts
- SetzeFontSizeMax: Constraints nicht �ndern, fest f�r Mindest-Fontsize in Create
- procedure SetzeNumFonts mit nicht-prop Schrift Consolas f�r Rfid
- InitMinBreiteArr entfernt, MinBreite immer neu berechnet
- FormPaint: gel�scht. interne Fonts in SetzeFontSizeMax,


--------------------------------------------------------------------------------
04.05.2017: 5.4 Released
--------------------------------------------------------------------------------


================================================================================


}

end.

