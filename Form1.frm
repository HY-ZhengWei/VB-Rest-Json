VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Begin VB.Form Form1 
   Caption         =   "VB����Rest�ӿڼ�Json��������"
   ClientHeight    =   8250
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   13050
   LinkTopic       =   "Form1"
   ScaleHeight     =   8250
   ScaleWidth      =   13050
   StartUpPosition =   3  '����ȱʡ
   Begin VB.TextBox TxtJson 
      Height          =   270
      Left            =   7560
      TabIndex        =   10
      Text            =   "Text1"
      Top             =   7680
      Width           =   5295
   End
   Begin VB.CommandButton CmdToJson 
      Caption         =   "Json����-->"
      Height          =   375
      Left            =   5880
      TabIndex        =   9
      Top             =   7680
      Width           =   1455
   End
   Begin RichTextLib.RichTextBox TxtRequest 
      Height          =   855
      Left            =   360
      TabIndex        =   6
      Top             =   1080
      Width           =   10695
      _ExtentX        =   18865
      _ExtentY        =   1508
      _Version        =   393217
      TextRTF         =   $"Form1.frx":0000
   End
   Begin VB.CommandButton CmdSend 
      Caption         =   "��������"
      Height          =   1455
      Left            =   11280
      TabIndex        =   4
      Top             =   480
      Width           =   1575
   End
   Begin VB.TextBox TxtURL 
      Height          =   270
      Left            =   360
      TabIndex        =   3
      Top             =   480
      Width           =   10695
   End
   Begin VB.TextBox TxtJsonKey 
      Height          =   270
      Left            =   1800
      TabIndex        =   1
      Text            =   "Text1"
      Top             =   7680
      Width           =   3855
   End
   Begin RichTextLib.RichTextBox TxtInfo 
      Height          =   4935
      Left            =   360
      TabIndex        =   0
      Top             =   2520
      Width           =   12495
      _ExtentX        =   22040
      _ExtentY        =   8705
      _Version        =   393217
      TextRTF         =   $"Form1.frx":008F
   End
   Begin VB.Label Label4 
      Caption         =   "�����ַ��"
      Height          =   255
      Left            =   360
      TabIndex        =   8
      Top             =   240
      Width           =   855
   End
   Begin VB.Label Label3 
      Caption         =   "���������"
      Height          =   255
      Left            =   360
      TabIndex        =   7
      Top             =   840
      Width           =   1095
   End
   Begin VB.Label Label2 
      Caption         =   "��Ӧ���ģ�"
      Height          =   255
      Left            =   360
      TabIndex        =   5
      Top             =   2280
      Width           =   1215
   End
   Begin VB.Label Label1 
      Caption         =   "Json�����ؼ��֣�"
      Height          =   255
      Left            =   360
      TabIndex        =   2
      Top             =   7680
      Width           =   1455
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Rem ZhengWei(HY) Create 2017-12-21


Private Sub CmdSend_Click()

    CmdSend.Enabled = False
    CmdToJson.Enabled = False


    Dim v_Response As String
    Dim v_XmlHttp
    

    Set v_XmlHttp = CreateObject("msxml2.xmlhttp")
    
    
    v_XmlHttp.Open "POST", TxtURL.Text, False
    v_XmlHttp.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
    v_XmlHttp.send TxtRequest.Text

    
    
    v_Response = v_XmlHttp.responseText
    TxtInfo.Text = v_Response
    Set v_XmlHttp = Nothing
    
    
    CmdSend.Enabled = True
    CmdToJson.Enabled = True

End Sub

Private Sub CmdToJson_Click()
    
    Dim v_Json     As Object
    Dim v_JsonData
    Dim v_JsonTmp  As Object

    Set v_Json = JSON.parse(TxtInfo.Text)
    v_JsonData = Split(TxtJsonKey.Text, ".")
    If IsArray(v_JsonData) Then
    
        Set v_JsonTmp = v_Json
        
        For i = 0 To UBound(v_JsonData) - 1
        
            Set v_JsonTmp = v_JsonTmp.Item(CStr(v_JsonData(i)))
        
        Next
        
        TxtJson.Text = v_JsonTmp.Item(CStr(v_JsonData(UBound(v_JsonData))))
    End If
    
End Sub

Private Sub Form_Load()

    TxtURL.Text = "http://218.21.3.20:5076/brp/services/avplan/aAUserData/queryAAUserData"
    TxtRequest.Text = "{""sysid"": ""SYS_LogWeb"",""sidv"": ""1.0"",""body"": {""innerid"": ""568dd7cc1ba68779fe295fb9ebe3288c"",""userid"": ""czd"",""userno"": ""50271""}}"
    TxtJsonKey.Text = "body.data.username"
    CmdToJson.Enabled = False
   
End Sub

