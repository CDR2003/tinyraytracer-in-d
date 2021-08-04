module gml.viewport;

import gml.vector;
import gml.ray;
import gml.math;

public class Viewport
{
    private Vector3 _origin;

    private float _width;

    private float _height;

    private float _focalLength;

    public this(const Vector3 origin, float width, float height, float focalLength)
    {
        _origin = origin;
        _width = width;
        _height = height;
        _focalLength = focalLength;
    }

    public this(float width, float height, float focalLength)
    {
        this(Vector3.zero, width, height, focalLength);
    }

    public float width() pure const nothrow
    {
        return _width;
    }

    public float height() pure const nothrow
    {
        return _height;
    }

    public float focalLength() pure const nothrow
    {
        return _focalLength;
    }

    public Ray getRay(float u, float v) pure const nothrow
    {
        immutable auto halfWidth = _width / 2;
        immutable auto halfHeight = _height / 2;
        auto direction = Vector3(_origin.x, _origin.y, _origin.z + focalLength).normalized;
        auto offset = Vector3.zero;
        offset.x = lerp(-halfWidth, halfWidth, u);
        offset.y = lerp(halfHeight, -halfHeight, v);
        offset.z = 0;
        direction += offset;
        return Ray(_origin, direction);
    }
}