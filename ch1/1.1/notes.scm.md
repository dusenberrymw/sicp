Section 1.1 The Elements of Programming
---

Every language has 3 basic mechanisms:
* primitive expressions
* means of combination
  * building compound elements from simpler ones
* means of abstraction
  * by naming compound elements and manipulating them as units

## 1.1.1 Expressions
* _expressions_ = statements that are _evaluated_ by the interpreter
  * `486` --> _486_
* _combinations_ = expressions formed by delimiting a list of expressions within parentheses in order to denote procedure application
  * ` (+ 137 349)` --> _486_
  * Uses _prefix_ notation
    * _operator_ = leftmost element in list
    * _operands_ = other elements in list
* _pretty-printing_ = write long combinations on separate lines with operands aligned vertically 

## 1.1.2 Naming and the Environment
* _symbol_ = an object with a unique character sequence known as the symbol's _print name_.
  * a _print name_ is _not_ the same thing as a variable name, and instead is just a sequence of characters that identifies a particular unique symbol
    * the character sequence is called a _print name_ because the sequence is what is printed out when the object is displayed
  * can think of a _symbol_ as an immutable data structure that will be _interned_, i.e. if the symbol is written the same, then it will always refer to the same object in memory (referential equality)
  * to refer to a literal symbol, must _quote_ it with a single quote (not a backtick)
    * `'foo` --> foo
    * in this case, it doesn't matter if there is a variable with the name `foo`, as `'foo` will always refer to the unique symbol with the print name _foo_, and `foo` != `'foo`
  * when a symbol is referenced, the interpreter will look for the symbol object, and if not found will make one
    * once the object for `'foo` is made the first time, every subsequent reference to `'foo` will always refer to the exact same object in memory, so `(eq? 'foo 'foo)` --> true
  * note that numbers such as `2` are just symbols, and are shorthand for `'2`
* _variable_ = an association between a _name_ that is itself a _symbol_ and a _value_ that is another _symbol_
  * **thus, a variable is not an object/thing itself, but rather just refers to the association between a symbol and a value**
  * In Scheme, name things with **define**
    * ` (define size 2)` --> size is a _symbol_ that is being used in this context as the _variable name_, and 2 is another _symbol_ that acts as the _value_ of this variable
    * Now typing the sequence _size_ will tell the interpreter to look for a variable with the name _size_ and display the value, which will be a _symbol_ (object) whose _print name_ is _2_.
      * ` size` --> 2
      * note that this will look to see if there is a name-value pair that uses the `'size` symbol as the name
    * can also use simple names to refer to results of compound operations, such as `circumference` in the following:
      ```scheme
      (define pi 3.14159)
      (define radius 10)
      (* pi (* radius radius)) --> 314.159
      (define circumference (* 2 pi radius))
      circumference --> 62.8318

      ```
* _environment_ = memory that keeps track of name-object pairs (technically the _globabl environment_)

## 1.1.3 Evaluation Combinations
* To evaluate a combination:
  1. Evaluate the subexpressions of the combination.
  2. Apply the procedure that is the value of the leftmost subexpression (the operator) to the arguments that are the values of the other subexpressions (the operands).
* Note that the above rule is _recursive_
* Evaluation can be represented by a tree, in which each node has branches for the operator and operands, and the values of the operands percolate upwards.
  * This is an example of a general kind of process known as _tree accumulation_
* Primitive cases:
  * values of numerals are the numbers that they name
  * values of built-in operators are the machine instruction sequences that carry out the corresponding operations
  * values of other names are the objects associated with those names in the environment
* _special forms_ = expressions, each with their own evaluation rule, that together make up the syntax of the programming language
  * `(define x 3)` is not a combination since it does _not_ apply **define** to both _x_ and _3_. Instead it assigns the value _3_ to the variable name _x_ (note that the name _x_ is a symbol, but it is being used to lookup the value of a variable with that symbol as the name) .

## 1.1.4 Compound Procedures
* _procedure definition_ = compound operation (_compound procedure_) can be given a name, and then be referred to as a unit 
  * In Scheme, define procedures with:
    * `(define (<name> <formal parameters>) <body>)`
    ```scheme
    (define (square x) (* x x))
    (square 3) --> 9

    ```

## 1.1.5 The Substitution Model for Procedure Application
* _substitution model_ = To apply compound procedure to arguments, evaluate body of procedure with each formal parameter replaced by the corresponding argument
  * note that this is a basic model, somewhat naive model
  * when calling (square 3), the interpreter grabs the body, (\* x x), then substitutes the argument _3_ for the formal parameter _x_ in the body, leading to (\* 3 3), which can then be evaluated to _9_
  * given:
    ```scheme
    (define (sum-of-squares x y)
      (+ (square x) (square y)))
    
    (define (f a)
      (sum-of-squares (+ a 1) (* a 2)))

    ```
  * evaluate (f 5):
    * `(f 5)`
    * retrieve body of f:
      * `(sum-of-squares (+ a 1) (* a 2))`
    * replace formal parameter _a_ by the argument 5:
      * `(sum-of-squares (+ 5 1) (* 5 2))`
    * evaluate operands, and then apply operator:
      * `(+ (square 6) (square 10))`
    * reduce using body of square:
      * `(+ (* 6 6) (* 10 10))`
    * evaluate operands: 
      * `(+ 36 100)` 
    * apply operator: 
      * `136` 

#### Applicative order vs. Normal order
* _applicative order_ = evaluate arguments first, and then apply operator
  * seen in above _substitution model_ example
  * **this is used in Lisp**
* _normal order evaluation_ = fully expand all arguments (operator & operands) down to primitive operators, and _then_ evaluate all at once
  * `(f 5)`
  * `(sum-of-squares (+ 5 1) (* 5 2))`
  * `(+ (square (+ 5 1)) (square (* 5 2)))`
  * `(+ (* (+ 5 1) (+ 5 1)) (* (* 5 2) (* 5 2)))`
  * `(+ (* 6 6) (* 10 10))`
  * `(+ 36 100)`
  * `136`

## 1.1.6 Conditional Expressions & Predicates
* _conditional_ in Scheme:
  ```scheme
  (cond (<predicate_1> <expression_1>)
        (<predicate_2> <expression_2>)
        .
        .
        .
        (<predicate_N> <expression_N>)) 

  ```
  * Each pair of expressions `(<p> <e>)` is called a _clause_, with the first term known as the _predicate_, and the second term known as the _consequent expression_.
  * Each clause is evaluated one at a time until a true predicate is found, at which point the value of the expression is returned.
  * If no predicates are true, the return value is _undefined_
  * The final clause can be an _else_ statement 
    * `(else <expression>)`
  * Example:
    ```scheme
    (define (abs x)
      (cond ((> x 0) x)
            ((= x 0) 0)
            ((< x 0) (- x))))

    ```
* Can also express a conditional in an _if_ form:
  * `(if <predicate> <consequent> <alternative>)`
  * _If_ the predicate evaluates to true, _then_ the &lt;consequent&gt; will be evaluated and returned.  
  * _Otherwise_, the &lt;alternative&gt; will be evaluated and returned.
  * Example:
    ```scheme
    (define (abs x)
      (if (< x 0)
          (- x)
          x))

    ```
* Logical operations:
  * `(and <e_1> ... <e_N>)`
    * Evaluate expressions one at a time, left to right.  If any expression is false, then stop evaluating and return false.  Otherwise, all expressions are true **and return the value of the last one**.
    * This is another example of a _special form_, because the subexpressions will not necessarily be evaluated each time 
  * `(or <e_1> ... <e_N>)`
    * Evaluate expressions one at a time, left to right.  If any expression is true, then stop evaluating and return the value of that expression.  Otherwise, all expressions are false and return false.
    * This is another example of a _special form_
  * `(not <e>)`
    * Return true if expression is false, and false if expression is true.

## 1.1.7 Example: Square Roots by Newton's Method
* consider the problem of computing square roots:
  * sqrt(x) = the _y_ such that _y_ >= 0 and y^2 == x
* now, determine how to actually implement this mathematical function into a computer procedure
* can use "Newton's Method":
  * we want to compute the square root of _x_
  * if we have a guess _y_, we can get a better guess by averaging _y_ with _x_/_y_
  * the following is a possible implementation:
    ```scheme
    (define (sqrt x)
      (sqrt-iter 1.0 x))

    (define (sqrt-iter guess x)
      (if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))

    (define (good-enough? guess x)
      (< (abs (- (square guess) x)) 0.001))

    (define (improve guess x)
      (average guess (/ x guess)))

    (define (average x y)
      (/ (+ x y) 2))

    ```
  * then ` (sqrt 9)` --> 3.00009155413138

## 1.1.8 Procedures as Black-Box Abstractions
* _procedural abstraction_ = the idea that the implementation of a procedure can be hidden, or _abstracted_ away, and thus can act like a black box
  * this means that a procedure could have several different implementations, but so long as they all compute the same result, they can be used interchangeably
  * ex: for the ` square` procedure, there could be different implementations, but it doesn't matter so long as they all compute the square of a number
    ```scheme
    (define (square x) (* x x))

    (define (square x) 
      (exp (double (log x))))

    (define (double x) (+ x x))

    ```
* _local names_
  * formal parameter names are local to the associated procedure, and are called _bound variables_
    * this means that the procedure definition _binds_ its formal parameter names
  * if the variable is _not_ bound, then it is _free_
  * the set of expressions for which a binding defines a name is called the _scope_ of the name
  * in the following example, `guess` and `x` are _bound_ variables, and `<`, `abs`, and `square` are _free_
    ```scheme
    (define (good-enough? guess x)
      (< (abs (- (square guess) x)) 0.001))

    ```
* _block structure_ = localize subprocedures for a given procedure by nesting them within the procedure itself as internal definitions
  * one goal here is to avoid naming conflicts between two procedures that may rely on subprocedures with the same (common) name, but with different intended results
    * ex: many numerical libraries may use functions like `good-enough?`, but may have different uses that don't produce the same results
      * in this case, the `good-enough?` for `sqrt` really is specific to `sqrt` itself, rather than being general purpose, so it would be best to nest it within `sqrt`
  * also allows us to break up a big program into smaller, tractable pieces that operate as units
  * ex: we can convert the `sqrt` procedure to use a block structure as follows:
    ```scheme
    (define (sqrt x)
      (define (good-enough? guess x)
        (< (abs (- (square guess) x)) 0.001))

      (define (average x y)
        (/ (+ x y) 2))

      (define (improve guess x)
        (average guess (/ x guess)))

      (define (sqrt-iter guess x)
        (if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))

      (sqrt-iter 1.0 x))

    ```
* _lexical scoping_ = free variables in a procedure refer to bindings made by enclosing procedure definitions. ie they are looked up in the environment in which the procedure is defind
  * ex: for the above `sqrt` example, since the `x` variable is bound to `sqrt`, the internal procedures are within the scope of `x`, so no need to explicitly pass it to those procedures
    ```scheme
    (define (sqrt x)
      (define (good-enough? guess)
        (< (abs (- (square guess) x)) 0.001))

      (define (average x y) ; this one is okay though, since this x isn't supposed to be the same
        (/ (+ x y) 2))

      (define (improve guess)
        (average guess (/ x guess)))

      (define (sqrt-iter guess)
        (if (good-enough? guess)
          guess
          (sqrt-iter (improve guess))))

      (sqrt-iter 1.0))

    ```

