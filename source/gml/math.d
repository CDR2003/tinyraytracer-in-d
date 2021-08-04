module gml.math;

@nogc public T lerp(T)(const T a, const T b, float t) pure nothrow
{
    return a * (1 - t) + b * t;
}