/*
 * Romberg
 * 2015-12-01
 * Author @Yang Keming
 * Information and Computing Science 1302
 * Student ID: 2013310200618
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

double Integral(double a, double b, double(*f)(double x, double y, double z), double TOL, double l, double t);
double f0(double x, double l, double t);
int IntPow(int x, int n);
int getIndex(int n, int m);

/*
 * input: 2 100 1
 * output: 1.68
 */
int main()
{
    double a = 0.0, b, TOL = 0.005, l, t;

    while(scanf("%lf %lf %lf", &l, &b, &t) != EOF)
        printf("%.2f\n", Integral(a, b, f0, TOL, l, t));
    /*
    b = 100, l = 2, t = 1;
    Integral(a, b, f0, TOL, l, t);
    */
    return 0;
}

/*
 * a and b are the upper and lower bounds of definite integral, f is the
 * kernel function, x is the integrand variable, y and z stands for l and
 * t in y(x)=lsin(tx), TOL represent target accuracy.
 */
double Integral(double a, double b, double(*f)(double x, double y, double z), double TOL, double l, double t)
{
    int k = 0, i = 0, index = 0, temp = 0;
    double T[10000] = {0}, h = b - a;
    T[index++] = (h / 2) * (f(a, l, t) + f(b, l, t));

    while(1)
    {
        k++;
        h /= 2;
        int cycle = IntPow(2, k);
        T[index] = T[getIndex(k - 1, 1)] / 2.0;

        for(i = 1; i < cycle; i += 2)
        {
            T[index] += h * f(a + i * h, l, t);
        }
        //printf("%d\t%f\n", k, T[index]);
        for(i = 1; i <= k; i++)
        {
            temp = IntPow(4, i);
            T[index + i] = (double)temp / (double)(temp - 1) * T[getIndex(k, i)] - T[getIndex(k - 1, i)] / (double)(temp - 1);
        }

        index += k + 1;
        //printf("[%d]\t%f\t%f\n", k, T[getIndex(k, k + 1)], T[getIndex(k, 1)]);

        if(fabs(T[getIndex(k, 1)] - T[getIndex(k - 1, 1)]) <= TOL)
        {
            //printf("over!\n");
            break;
        }
    }

    return T[getIndex(k, 1 + k)] / 100;
}

/* The kernel function of arc integral */
double f0(double x, double l, double t)
{
    return sqrt(1.0 + l * l * t * t * cos(t * x) * cos(t * x));
}

/* x^n */
int IntPow(int x, int n)
{
    int temp = 1;

    while(n-- > 0)
    {
        temp *= x;
    }

    return temp;
}

/* get the index of row n and col m */
int getIndex(int n, int m)
{
    int i, temp = 0;

    for(i = 1; i <= n; i++)
    {
        temp += i;
    }

    return temp + m - 1;
}
