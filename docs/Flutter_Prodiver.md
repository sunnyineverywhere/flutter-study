# Flutter Provider

## 1. Provider란?

- 플러터의 상태 관리 라이브러리 중 하나로, 여러 페이지에서 사용되는 상태가 필요한 상황(전역 상태관리)에서 유용하게 사용된다.

- **상태**란?
  > <p>1. 위젯이 빌드되는 동시에 읽을 수 있고 <br>
  >  2. 위젯의 생명 주기동안 변경할 수 있는 정보를 말한다.
  > </p>
  > ⇒ 보통 사용자가 어플과 상호작용하며 <b>변화하는 데이터</b>를 말한다.
- **생성 부분** + **소비 부분**으로 나뉘며
  - 생성 부분은 데이터에 대한 Provider를 만들고
  - 소비 부분에서는 Provider를 통해 데이터를 불러오거나 수정함

## 2. 예제

> [🔗 Flutter Provider Example](https://github.com/sunnyineverywhere/flutter-study/tree/main/flutter_state_provider)  
> → 위의 링크에서 확인 구체적인 코드 확인 가능</p>

> 예제에서는 `name`과 `city` 두 파라미터로 구성된 `User` **데이터 모델의 리스트**를 전역 상태로 관리하는 간단한 페이지를 구성한다.

<br>

### Step 1. User 클래스와 UserNotifier 생성

```dart
// user.dart

class User {
  String name;
  String city;

  User(this.name, this.city);
}
```

```dart
// user_controller.dart

import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_state_provider/model/user.dart';

class UserNotifier extends ChangeNotifier {
  List<User> _userList = [];
  int _age = 0;
  int _height = 0;

  UnmodifiableListView<User> get userList => UnmodifiableListView(_userList);

  addUser(User user) {
    _userList.add(user);
    notifyListeners(); // change notifier
  }

  deleteUser(index) {
    _userList.removeWhere((_user) => _user.name == _userList[index].name);
    notifyListeners();
  }

  incrementAge() {
    _age++;
    notifyListeners();
  }

  incrementHeight() {
    _height++;
    notifyListeners();
  }
}
```

**❓ ChangeNotifier**

- Flutter SDK에서 제공하는 클래스로, 변화를 구독하는 리스너에게 값의 변화를 알려준다.
- O(1) for adding listeners and O(N) for removing listeners and dispatching notifications (where N is the number of listeners) <br>
  ⇒ 리스너 추가는 O(1), 리스너 제거 및 알림 발송은 O(N)의 시간 복잡도를 가진다. (여기서 N은 리스너 수)
- 클래스의 메서드에 작성된 **notifyListeners()**를 통해 리스너에게 데이터의 변화를 알린다(리스너 알림 발송).

### Step2. void main()의 runApp() 내부에 `MultiProvider`를 사용하여 전역상태관리 클래스 추가

```dart
// main.dart
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserNotifier()),
      ],
      child: MyApp(),
    ),
  );
}
```

**❓ ChangeNotifierProvider**

- Listens to a ChangeNotifier ⇒ ChangeNotifier를 구독한다(리슨).
- providers에 작성한 Notifier들을 꼭 등록해 주어야 정상적으로 작동한다.
- 자세한 설명은 [공식문서](https://pub.dev/documentation/provider/latest/provider/ChangeNotifierProvider-class.html) 참조

### Step3. Provider를 사용할 위젯트리 제일 상단의 위젯에 `Notifier` 객체를 생성한다.

```dart
// home_page.dart
Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);
}
```

### Step4. (예제) addUser()를 활용해 보자.

```dart
body: SingleChildScrollView(
        padding: EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InputForm(
                labelText: 'Name',
                onSaved: (String? value) {
                  _name = value;
                },
              ),
              SizedBox(height: 16),
              InputForm(
                labelText: 'City',
                onSaved: (String? value) {
                  _city = value;
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MainButton(
                    text: 'Add',
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;
                      _formKey.currentState!.save();
                      userNotifier.addUser(User(_name!, _city!));
                    },
                  ),
                  SizedBox(width: 8),
                  MainButton(
                    text: 'List',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserListScreen()));
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              UserList()
            ],
          ),
        ),
      ),
```

이 중 함수가 Notifier가 사용되는 부분을 보면,

```dart
MainButton(
    text: 'Add',
    onPressed: () {
        if (!_formKey.currentState!.validate()) return;
        _formKey.currentState!.save();
        userNotifier.addUser(User(_name!, _city!));
    },
),
```

`userNotifier.addUser()`에서 전역상태 관리 객체에 User를 넣고, 다른 위젯에서도 생성된 UserNotifier를 구독한다면 실시간으로 위젯끼리 변화된 데이터의 상태를 감지한다.
