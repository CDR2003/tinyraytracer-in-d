module gml.math.ray;

import gml.math.vector;

struct Ray
{
    public Vector3 origin;

    public Vector3 direction;

    public Vector3 at(float t)
    {
        return this.origin + this.direction * t;
    }
}