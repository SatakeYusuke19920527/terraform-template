# Terraform × Azure基本構成
## アーキテクチャ
![アーキテクチャ](/terraform.png)

## 構成
1. インターネット上よりアクセスは Azure Load Balancer にて受け付ける
2. Azure Load Balancer から Windows Serverへ接続はNSGにて許可
3. Windows Server にて IIS をインストールし、Webサーバとして動作
4. SQLServerへはPrivateEndpointを利用し、プライベートIPアドレスで接続
5. WindowsServerへの接続は、Azure Bastionを利用し、プライベートIPアドレスで接続