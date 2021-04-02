# 📱 iOS 2진/10진 계산기

## Jay, Henry, Tak

<br/>

## 💬 프로젝트 키워드
  - 프로토콜(Protocol)
  - 제네릭(Generic)
  - 클로저(Closure)

<br/>

## 🏢 설계하기
  - 프로젝트의 설계 과정에서 가장 중요한 부분은 '공통 연산 부분을 어떤식으로 구현할 것인가'였습니다. 10진 계산기와 2진 계산기가 공통적으로 가진 연산이 있고, 각자만 가진 연산이 있습니다. 이를 단순히 상속으로 처리할 수 있지만 프로토콜을 학습하며 이를 적용하는 것이 더 적합한지 고민했습니다. 우선 고려사항을 보면 아래와 같습니다.

    > - 10진 계산기와 2진 계산기가 있습니다. 이를 각각 구현할 것인지, 한 계산기에서 입력에 따라 다른 역할로 변경될 수 있도록 하나의 계산기로 구현할 것인지를 결정할 필요가 있습니다. 
    > - 두 계산기가 공통적으로 갖는 연산이 존재합니다. 
    > - 각 계산기가 개별적으로 가진 연산이 존재합니다.

  - 두 종류의 계산기가 존재: 회의를 통해 각각 개별적인 기능을 가진 계산기가 좋다는 결론이 나왔습니다. 한 계산기에 두 계산기의 기능을 구현하면 쓸데없이 복잡해지고, 굳이 하나에 모든 기능을 담을 필요가 없기 때문입니다. 모든 연산이 같고 단지 차이가 2진과 10진 numeric system이라면 의미 있는 설계일 수 있지만 실제로 다른 작동을 하는 기능이 많습니다.

  - 공통으로 갖는 연산이 존재: 공통으로 갖는 연산을 상속을 통해 처리할 것인지, 프로토콜로 구현할 것인지 정의가 필요합니다.

  - 개별적인 연산이 존재: 각 개별 연산을 어떤식으로 정의할 것인지 결정해야 합니다.

<br/>

## 🎯 고민 Point

1. 계산기 구현의 중간과정을 어떻게 처리할 것인가?

   크게 두가지의 방식이 있을 수 있습니다.

   1. 연산자를 입력할 때마다 중간 연산을 완료하여 완료된 값을 기준으로 새 연산을 실행하는 방법
   2. 연산자를 입력 받을 때마다 그때까지 받은 입력의 연산을 모두 받아 연산자 우선순위를 기준으로 연산하는 방법

   아이폰 계산기 어플을 기준으로 했을 때, 10진 계산기는 2번의 방식을 따릅니다. 예시로 삼을 2진 계산기가 없어 2진 계산기 역시 2번의 방식으로 구현하기로 했습니다.

2. ~~연산자 우선순위~~

   1-2의 방식을 따르려면 연산자 우선순위가 필요합니다. 연산자 우선순위는 아래와 같이 구현했습니다.

   ![](https://images.velog.io/images/jayb/post/6e32ee16-d410-409e-b0cf-8f11c9ea8ede/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA%202021-03-26%20%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE%205.22.45.png)

   문제는 여기서 .notAnd, notOr 연산이었습니다. notAnd 연산과 notOr 연산의 우선 순위를 알 수가 없어서 우선 캠퍼들과 대화를 통해 not의 우선순위와 동치시켰습니다. 이는 이후 더 많은 대화와 자료를 통해 수정할 예정입니다. 아직 답을 모르는 상태입니다(and에 가까운지 not에 가까운지).

3. ~~Operator 열거형이 String을 rawValue로 갖는 이유가 나중에 stack에서 입력받아 사용할때 필요~~

4. 10진 연산을 Int로 형변환이 가능한 것은 일단 형변환 해서 연산하고 Double인 것은 Double로 연산할 수도 있고, 모든 타입을 Double로 연산한 후 결과가 Int면 Int로 변환할 수 있습니다. 후자가 더 편하지만 부동소수점 특성상 이렇게 되면 Int + Int가 Double이 되거나 연산의 결과가 달라지는 경우가 있을 수 있을 것 같습니다. 부동소수점 문제를 처리할 필요가 있어보입니다.

5. 연산시에 "+"처럼 String으로 값이 들어왔을 때, 연산자의 enum type을 반환해야합니다. enum의 rawValue에 해당 연산자 String을 할당하면 case add = "+" 같은 구조가 되고, 입력받은 String을 전체 순회하며 같은 연산자 타입이 존재할 때 그 타입을 반환해도 됩니다. 하지만 이 방식은 rawValue의 원래 의미에 적합하지 않고, O(N)이라는 단점이 있습니다. 더 나은 로직을 생각할 필요가 있을 것 같습니다.

   <br/>

## 🏢 연산자 구현 구조

위의 열거형 방식을 정하기 전 연산자를 구현하는 방식을 정할 필요가 있었습니다. 생각해본 구조는 다음과 같습니다.

1. 입력을 String으로 받은 후, 변환해서 함수의 파라미터로 넣어주기

   ```swift
   func andOperation(_ firstElement: Int, and secondElement: Int) -> String {
           return String(firstElement & secondElement)
       }
       
       func nandOperation(_ firstElement: Int, nand secondElement: Int) -> String {
           return String(~(firstElement & secondElement))
       }
       ...
   ```

   위의 구조 장점은 코드 리딩이 심플합니다. 하지만 10진 계산기의 경우 Int, Double형이 가능하고 2진 계산기는 Int로 표현하므로 상황에 따라 변환의 가능성이 다양하고 Stack<String>의 요소를 꺼내올 때마다 해당 변환을 반복해야하므로 불필요한 비용이 발생할 수 있습니다. 이 구조에서는 

   ```swift
   protocol BinaryOperation
   protocol DecimalOperation
   class BaseOperator
   class BinaryOperator: BaseOperator, BinaryOperation
   class DecimalOperator: BaseOperator, DecimalOperation
   ```

   을 통해서 구현했습니다.

2. 입력은 무조건 String으로 받아 내부에서 숫자로 변환하여 처리하기

   ```swift
   func add(firstElement: String, secondElement: String) throws -> String {
           if let intFirstElement = Int(firstElement), let intSecondElement = Int(secondElement) { return String(intFirstElement + intSecondElement) }
           guard let doubleFirstElement = Double(firstElement), let doubleSecondElement = Double(secondElement) else { throw CalculatorError.notNumericInput }
           return String(doubleFirstElement + doubleSecondElement)
       }
   ```

   덧셈 연산은 크게 10진 계산기의 덧셈, 2진 계산기의 덧셈이 있고, 10진에서도 Int형과 Double형의 계산이 있을 수 있습니다. 이 때, 10진 계산에서 Int형 계산을 Double로 처리한 후 결과가 Int가 가능하면 Int로 처리할 수도 있고, 애초에 Int형이라면 Int로 변형한 후 연산하는 방식도 있습니다. 위의 식에서는 후자의 방식으로 둘다 Int라면 결과를 Int로 반환해 String으로 전환하고, 아니라면 Double로 변환해 연산합니다.

3. 연산 자체를 클로저로 구현하여 메소드의 파라미터로 입력

   ```swift
   var doubleOperation: (Double, Double) -> Double {
           switch self {
           case .add: return { $0 + $1 }
           case .subtract: return { $0 - $1 }
           case .multiply: return { $0 * $1 }
           case .divide: return { $0 / $1 }
           }
       }
   ```

   

<br/>

## 👍 연산자 우선순위 구현하기

- 가장 고민이 많았던 부분 중 하나입니다. 처음에는 enum을 활용해서 연산자에 우선순위에 따라 rawValue를 임의로 주고, rawValue를 반환받아 비교하는 로직을 생각했습니다. 하지만 만족스럽지 않아 더 고민하였고, 우선순위 자체를 enum으로 만들어 구현하였습니다.

  ```swift
  enum OperationPrecedenceTier: Int {
      case topTier = 160
      case secondTier = 140
      case thirdTier = 120
  }
  
  struct OperationPrecedenceTable {
      let precedence: [String:Int] = [
          "+" : OperationPrecedenceTier.thirdTier.rawValue,
          "-" : OperationPrecedenceTier.thirdTier.rawValue,
          "*" : OperationPrecedenceTier.topTier.rawValue,
          "/" : OperationPrecedenceTier.topTier.rawValue,
          "~" : OperationPrecedenceTier.topTier.rawValue,
          "&" : OperationPrecedenceTier.topTier.rawValue,
          "~&" : OperationPrecedenceTier.topTier.rawValue,
          "|" : OperationPrecedenceTier.thirdTier.rawValue,
          "~|" : OperationPrecedenceTier.thirdTier.rawValue,
          "^" : OperationPrecedenceTier.thirdTier.rawValue,
          "<<" : OperationPrecedenceTier.secondTier.rawValue,
          ">>" : OperationPrecedenceTier.secondTier.rawValue,
      ]
  }
  ```

  연산자를 입력받을 때 String으로 받을 것이기 때문에 바로 연산자 우선순위를 알 수 있도록 Dictionary로 구성하였습니다. 하지만 여기에서 피드백으로 Comparable에 대한 학습을 권유해주셨습니다. comparable을 학습해서 적용해본 경험은 이번 프로젝트에서 가장 재미있게 한 부분인 것 같습니다. 적용한 코드는 아래와 같습니다.

  ```swift
  enum OperationPrecedenceTier: Comparable {
      case thirdTier
      case secondTier
      case topTier
  }
  
  struct OperationPrecedenceTable {
      let precedence: [String:OperationPrecedenceTier] = [
          "+" : OperationPrecedenceTier.thirdTier,
          "-" : OperationPrecedenceTier.thirdTier,
          "*" : OperationPrecedenceTier.topTier,
          "/" : OperationPrecedenceTier.topTier,
          "~" : OperationPrecedenceTier.topTier,
          "&" : OperationPrecedenceTier.topTier,
          "~&" : OperationPrecedenceTier.topTier,
          "|" : OperationPrecedenceTier.thirdTier,
          "~|" : OperationPrecedenceTier.thirdTier,
          "^" : OperationPrecedenceTier.thirdTier,
          "<<" : OperationPrecedenceTier.secondTier,
          ">>" : OperationPrecedenceTier.secondTier,
      ]
  ```

  비슷한 코드이지만 rawValue라는 부분이 없어지고, 의미없는 숫자 160 등이 사라지면서 훨씬 직관적이고 의미있는 코드가 되었습니다. 가장 재미있는 학습이었습니다.

