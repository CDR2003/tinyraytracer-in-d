module gml.scene_object;

import std.container.array;
import gml.vector;
import gml.hit_result;
import gml.ray;

public abstract class SceneObject
{
    private Vector3 _position;

    public this()
    {
        _position = Vector3.zero;
    }

    public Vector3 position() pure const nothrow
    {
        return _position;
    }

    public void position(const Vector3 position) pure nothrow
    {
        _position = position;
    }

    public abstract HitResult[] hit(const Ray ray) pure const;
}