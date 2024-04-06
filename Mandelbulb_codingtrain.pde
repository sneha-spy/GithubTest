import peasy.*;

int DIM = 128;
PeasyCam cam;
//create an array of PVectors

ArrayList<PVector> mandelbulb = new ArrayList<PVector>();

void setup() {
  size (600, 600, P3D);
  windowMove(1200, 100);
  cam = new PeasyCam( this, 600);
  
  
  for (int i=0; i<DIM; i++) {
    for (int j=0; j<DIM; j++) {
      
      boolean edge =false;
      for (int k=0; k<DIM; k++) {
        float x=map(i, 0, DIM, -1, 1);
        float y=map(j, 0, DIM, -1, 1);
        float z=map(k, 0, DIM, -1, 1);
        
        
        PVector zeta = new PVector(0,0,0);
        int n=8;
        int maxiter=10;
        int iter=0;
        while (true){
          
          Spherical sphericalZ = spherical(zeta.x,zeta.y,zeta.z);
          
          float newx = pow(sphericalZ.r,n)*sin(n*sphericalZ.theta)*cos(n*sphericalZ.phi);
          float newy = pow(sphericalZ.r,n)*sin(n*sphericalZ.theta)*sin(n*sphericalZ.phi);
          float newz = pow(sphericalZ.r,n)*cos(n*sphericalZ.theta);
          //the stray x, y,z  added here act as the c
          zeta.x = newx + x;
          zeta.y = newy + y;
          zeta.z = newz + z;
        
          iter++;
          if (sphericalZ.r>16){
            if (edge){
              edge= false;
            }
            break;
          }
          if (iter > maxiter){
            if (!edge){
            edge=true;
            mandelbulb.add( new PVector(x*100,y*100,z*100));
            }
            break;
        }
      }
        
        
       
        
      }
    }
  }
}

class Spherical {
    float r, theta, phi;
    Spherical(float r, float theta, float phi){
    this.r=r;
    this.theta =theta;
    this.phi=phi;
  }
}

Spherical spherical(float x, float y, float z){   
  
     float r= sqrt(x*x + y*y +z*z);
     float theta=atan2(sqrt(x*x +y*y),z);
     float phi= atan2(y,x);
     return new Spherical(r, theta, phi);
}


void draw(){
  background (0);
  
  for (PVector v:mandelbulb){
    stroke(255);
    point (v.x, v.y, v.z);
  }
  
}
