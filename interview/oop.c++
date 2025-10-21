//polymorphism
int add(int a, int b);
float add(float a, float b);

//polymorphism
class Shape { virtual void draw() {} };
class Circle : public Shape { void draw() override { cout << "Circle"; } };

//Q3: What’s the difference between inheritance and composition?
//Inheritance is is-a, composition is has-a.

//overriding
class Base { virtual void print(); };
class Child : public Base { void print() override; };
