"""
Pattern Recognition Dataset class

Should provide a simple and consistent way to deal with datasets.
A dataset contains:
    data     a data matrix of NxD,  where N is the number of objects,
             and D is the number of features
    targets  the output values that should be predicted from the objects
Additionally, a dataset name, or feature labels can be provided.

The main goal is to keep the labels consistent with the data, when you
try to slice your dataset, or when you want to split your data in a
training and test set:
    a = gendatb([50,50])     generate a Banana prdataset
    [x,z] = gendat(a,0.8)    split in train and test set
    b = a[:,:1]              only select the first feature
    c = a[30:50,:]           only select a few samples
"""

import numpy
import copy

import matplotlib.pyplot as plt
from scipy.cluster import hierarchy
from mpl_toolkits import mplot3d

# === prdataset ============================================
class prdataset(object):
    "Prdataset in python"

    def __init__(self,data,targets=None):
        if isinstance(data,prdataset):
            self.__dict__ = data.__dict__.copy()
            return
        if not isinstance(data,(numpy.ndarray, numpy.generic)):
            data = numpy.array(data,ndmin=2)
            if not isinstance(data,(numpy.ndarray, numpy.generic)):
                raise TypeError('Data matrix should be a numpy matrix.')
        if targets is not None:
            if not isinstance(targets,(numpy.ndarray, numpy.generic)):
                raise TypeError('Target vector should be a numpy matrix.')
            assert (data.shape[0]==targets.shape[0]), \
                    'Number of targets does not match number of data samples.'
            if (len(targets.shape)<2):
                targets = targets[:,numpy.newaxis]
        else:
            targets = numpy.zeros(data.shape[0])
        self.name = ''
        self.featlab = numpy.arange(data.shape[1])
        self.setdata(data)
        self.targets = targets
        self.targettype = 'crisp'
        self._targetnames_ = ()
        self._targets_ = []
        self.prior = []
        self.user = []

    def __str__(self):
        sz = self.data.shape
        if (len(self.name)>0):
            outstr = "%s %d by %d prdataset" % (self.name,sz[0],sz[1])
        else:
            outstr = "%d by %d prdataset" % (sz[0],sz[1])
        if (self.targettype=='crisp'):
            cnt = self.classsizes()
            nrcl = len(cnt)
            if (nrcl==0):
                outstr += " with no targets"
            elif (nrcl==1):
                outstr += " with 1 class: [%d]"%sz[0]
            else:
                outstr += " with %d classes: [%d"%(nrcl,cnt[0])
                for i in range(1,nrcl):
                    outstr += " %d"%cnt[i]
                outstr += "]"
        elif (self.targettype=='regression'):
            outstr += " with continuous targets."
        return outstr

    def float(self):
        return self.data.copy()
    def __pos__(self):
        return self.float()
    def __add__(self,other):
        newd = copy.deepcopy(self)
        if (isinstance(other,prdataset)):
            other = other.float()
        newd.data += other
        return newd
    def __sub__(self,other):
        newd = copy.deepcopy(self)
        if (isinstance(other,prdataset)):
            other = other.float()
        newd.data -= other
        return newd
    def __mul__(self,other):
        #print('prdataset multiplication with right')
        #print('   self='+str(self))
        #print('   other='+str(other))

        if (isinstance(other,prdataset)):
            other = other.float()
        if (isinstance(other,(int,float))):
            newd = copy.deepcopy(self)
            newd.data *= other
            return newd
        else:
            return NotImplemented
    def __rmul__(self,other):
        #print('prdataset multiplication with right')
        #print('   self='+str(self))
        #print('   other='+str(other))

        if (isinstance(other,prdataset)):
            other = other.float()
        if (isinstance(other,(int,float))):
            newd = copy.deepcopy(self)
            newd.data *= other
            return newd
        else:
            return NotImplemented
    def __div__(self,other):
        newd = copy.deepcopy(self)
        if (isinstance(other,prdataset)):
            other = other.float()
        newd.data /= other
        return newd

    # Returns unique label objects
    def lablist(self):
        return numpy.unique(self.targets)

    # Returns indexes of labels
    def nlab(self):
        # Save values to ll and indexes to I
        (ll,I) = numpy.unique(self.targets,return_inverse=True)
        I = numpy.array(I)
        # Transpose indexes and return only these, even repeated ones
        I = I[:,numpy.newaxis]
        return I

    # Return a modified lab index list if there's only two classes
    def signlab(self,posclass=1):  # what is a good default?
        ll = self.lablist()
        if (len(ll)>2):
            raise ValueError('Labels +-1 only for two-class problems.')
        lab = self.nlab()
        if (posclass==0):
            lab = 1-2.0*lab # value 0 becomes 1 everything else is negative (decreased by 2)
        else:
            lab = 2.0*lab-1 # value 0 becomes -1 everything else is positive and increased by 1
        return lab

    # Returns dataset with data as well as feature labels if shape gets misalign
    def setdata(self,data):
        self.data = data
        self.shape = data.shape
        if len(self.featlab) != data.shape[1]:
            self.featlab = ['Feature 0']
            for i in range(1,data.shape[1]):
                self.featlab.append('Feature %d'%i)
        return self

    # Return number of objects of each unique classes (targets, or labels)
    def classsizes(self):
        if (self.targettype=='regression'):
            return None
        try:       # in older versions of numpy the 'count' is not available
            (k,count) = numpy.unique(numpy.array(self.targets),return_counts=True)
        except:
            ll = numpy.unique(numpy.array(self.targets))
            count = numpy.zeros((len(ll),1))
            for i in range(len(ll)):
                count[i] = numpy.sum(1.*(self.targets==ll[i]))
        return count

    # Set dataset name
    def setname(name):
        self.name = name
    
    # Get dataset name
    def getname(self):
        return self.name

    # Return number of unique classes in dataset
    def nrclasses(self):
        # ADDED - UNTESTED
        if not isinstance(self,prdataset):
                raise TypeError('Not a dataset!')
        else:
            ll = numpy.unique(self.targets)
        return len(ll)
        
    # Return all objects of class cname
    def findclass(self,cname):
        ll = numpy.unique(self.targets)
        I = numpy.where(ll==cname)
        return I[0][0]

    # Return item at key
    def __getitem__(self,key):
        newd = copy.deepcopy(self)
        # be resistant to 'tuples' that come out of (..).nonzero()
        if isinstance(key[0],tuple):
            raise TypeError("Object indices should be a integer vector "\
                    "(used all output\nfrom I=(..).nonzero()? Use only I[0]).")
        # be resistant to 'integer ndarray' indices:
        if isinstance(key[0],numpy.ndarray):
            key = (key[0].tolist(), key[1])
        if isinstance(key[1],numpy.ndarray):
            key = (key[0], key[1].tolist())
        # be resistant to 'single integer' indices:
        if isinstance(key[0],int):
            key = ([key[0]], key[1])
        if isinstance(key[1],int):
            key = (key[0], [key[1]])
        # when we select columns (features), we have to take care of the
        # feature labels, because that is a *list*:
        if isinstance(key[1],slice):
            # we select columns: in the data and the feature labels
            newd.data = newd.data[:,key[1]]
            newd.featlab = newd.featlab[key[1]]
        elif isinstance(key[1],list):
            if (max(key[1])>=newd.data.shape[1]):
                raise ValueError("Feature indices should be smaller than %d."%newd.data.shape[1])
            newd.data = newd.data[:,key[1]] # ndarrays can handle it
            newd.featlab = [newd.featlab[i] for i in key[1]]
        else:
            print(key[1])
            print(type(key[1]))
            raise ValueError("Only slices or integer lists can be used in indexing.")
        # we select objects: in the data and targets
        newd.data = newd.data[key[0],:]
        newd.targets = newd.targets[key[0]]
        # select rows from targets
        if (len(newd._targets_)>0):
            newd._targets_ = newd._targets_[key[0],:]
        # make the shape consistent:
        newd.shape = newd.data.shape
        return newd

    # Set item at key
    def __setitem__(self,key,item):
        self.data[key] = item

    # get prior 
    def getprior(self):
        if (len(self.prior)>0):
            return self.prior
        sz = self.classsizes()
        return sz/float(numpy.sum(sz))

    # Concatenate two datasets
    def concatenate(self,other,axis=None):
        # Concatenate dataset with something else
        # If the axis is not given, try to infer from the sizes along
        # which direction the concatenation should be performed. The first guess is along dimension 0:
        if (axis is None):
            if (self.shape[1]==other.shape[1]):
                axis = 0
            elif (self.shape[0]==other.shape[0]):
                axis = 1
            else:
                raise ValueError('Datasets do not match size.')

        out = copy.deepcopy(self)
        if (axis==0):
            out = out.setdata(numpy.concatenate((out.data,other.data),axis=0))
            out.targets = numpy.concatenate((out.targets,other.targets),axis=0)
            out._targets_ = numpy.concatenate((out._targets_,other._targets_),axis=0)
        elif (axis==1):
            newfeatlab = numpy.concatenate((out.featlab,out.featlab))
            out = out.setdata(numpy.concatenate((out.data,other.data),axis=1))
            out.featlab = newfeatlab
        else:
            raise ValueError("Concatenation is only possible along axis 0 or 1.")
        return out

    # Sets target labels, regardless of them already existing
    def settargets(self,labelname,targets):
        # does the size match?
        if (len(targets.shape)==1):
            targets = targets[:,numpy.newaxis]
        if (targets.shape[0] != self.data.shape[0]):
            # try transposing:
            targets = targets.transpose()
            if (targets.shape[0] != self.data.shape[0]):
                raise ValueError("Number of targets does not match number of objects.")
        # does labelname already exist? then overwrite
        if labelname in self._targetnames_:
            I = self._targetnames_.index(labelname)
            self._targets_[:,I:(I+1)] = targets
        # add a new label:
        else:
            if (len(self._targetnames_)>0):
                self._targetnames_.append(labelname)
                self._targets_ = numpy.append(self._targets_,targets,1)
            else:
                if not isinstance(labelname,list):
                    labelname = [labelname]
                self._targetnames_ = labelname
                self._targets_ = targets

    # Returns object at labelname
    def gettargets(self,labelname):
        if labelname in self._targetnames_:
            I = self._targetnames_.index(labelname)
            return self._targets_[:,I:(I+1)]
        else:
            return None

    # Prints targets with label I or all targets
    def showtargets(self,I=None):
        if I is None:
            if (len(self._targetnames_)>0):
                print("This dataset has these targets defined:"),
                print(self._targetnames_)
            else:
                print("No targets defined.")
        else:
            targets = self.gettargets(I)
            if I is None:
                print("Cannot find targets ", I)
            else:
                print(targets)

# === useful functions =====================================
def scatterd(a,clrs=None):
    if (clrs is None):
        clrs = a.nlab().flatten()
    sz = a.data.shape
    if (sz[1]>1):
        plt.scatter(a.data[:,0],a.data[:,1],c=clrs)
        ylab = a.featlab[1]
    else:
        plt.scatter(a.data[:,0],numpy.zeros((sz[0],1)),c=clrs)
        ylab = ''
    plt.title(a.name)
    plt.xlabel('Feature '+str(a.featlab[0]))
    plt.ylabel('Feature '+str(ylab))
    plt.winter()

def scatter3d(a):
    clrs = a.nlab().flatten()
    sz = a.data.shape
    if (sz[1]>2):
        ax = plt.axes(projection='3d')
        ax.scatter3D(a.data[:,0],a.data[:,1],a.data[:,2],c=clrs)
        ylab = a.featlab[1]
        zlab = a.featlab[2]
    else:
        raise ValueError('Please supply at least 3D data.')
    plt.title(a.name)
    ax.set_xlabel('Feature '+str(a.featlab[0]))
    ax.set_ylabel('Feature '+str(ylab))
    ax.set_zlabel('Feature '+str(zlab))
    plt.winter()

def scatterr(a):
    sz = a.data.shape
    if (sz[1]==1):
        plt.scatter(a.data[:,0],a.targets)
        plt.title(a.name)
        plt.xlabel('Feature '+str(a.featlab[0]))
        plt.ylabel('Target')
        plt.winter()
    elif (sz[1]==2):
        ax = plt.axes(projection='3d')
        ax.scatter3D(a.data[:,0],a.data[:,1],a.targets)
        ylab = a.featlab[1]
        plt.title(a.name)
        ax.set_xlabel('Feature '+str(a.featlab[0]))
        ax.set_ylabel('Feature '+str(ylab))
        ax.set_zlabel('Targets')
    else:
        raise ValueError('Please supply at least 2D data.')

def dendro(X, link):
    """
    Plots the hierarchical clustering as a dendrogram
    :param X: prdataset feature vectors
    :param link: linkage type to be used for the dendogram generation
    """
    z = hierarchy.linkage(X, link)
    plt.figure()
    dn = hierarchy.dendrogram(z, orientation='top', show_leaf_counts=True)
    plt.show()
    return dn

def fusion_graph(X, link):
    """
    Plots the hierarchical clustering fusion graph. This functions also
    plots the dendrogram out of which the fusion graph is generated
    :param X: prdataset feature vectors
    :param link: linkage type to be used for the fusion graph generation
    """
    dn = dendro(X, link)
    # Compute fusion levels and number of clusters
    fusion_levels = [el[1] for el in dn['dcoord']]
    fusion_levels = sorted(fusion_levels, key=float, reverse=True)  # sort in descending order
    clusters = [c + 1 for c in range(len(fusion_levels))]
    # Plot fusion graph
    plt.plot(clusters, fusion_levels, 'o-')
    plt.xticks(numpy.arange(1, len(clusters) + 1, step=int(len(clusters)/5)))
    plt.ylabel('Fusion level')
    plt.xlabel('Number of clusters')
    plt.title('Fusion graph')
    plt.show()

# === datasets ===============================

def seldat(x,cl):
    newd = copy.deepcopy(x)
    I = (x.nlab()==cl).nonzero()
    return newd[I[0],:]

def genclass(n,p):
    "Generate class frequency distribution"
    if isinstance(n,int):
        n = [n]  # make a list
    n = numpy.asarray(n)
    if (len(n)>1):
        return n
    if (len(n.shape)>1):
        return n
    p = numpy.asarray(p)
    if (numpy.abs(numpy.sum(p)-1)>1e-9):
        raise ValueError('Probabilities do not add up to 1.')
    c = len(p)
    P = numpy.cumsum(p)
    P = numpy.concatenate((numpy.zeros(1),P))
    z = numpy.zeros(c,dtype=int)
    x = numpy.random.rand(numpy.sum(n))
    for i in range(0,c):
        z[i] = numpy.sum((x>P[i]) & (x<P[i+1]))
    return z

def genlab(n,lab):
    if (isinstance(n,int)):
        n = [n]
    if (isinstance(lab,str)):
        lab = [lab]
    if (len(n)!=len(lab)):
        raise ValueError('Number of values in N should match number in lab')
    out = numpy.repeat(lab[0],n[0])
    for i in range(1,len(n)):
        out=numpy.concatenate((out,numpy.repeat(lab[i],n[i])))
    
    return out

def gendat(x,n,seed=None):
    nrcl = x.nrclasses()
    clsz = x.classsizes()
    prior = x.getprior()
    # and all the casting:
    if isinstance(n,float):  # we start with a fraction
        n = n*clsz
    if isinstance(n,int):    # we start with a total number
        n = genclass(n,prior)
    if isinstance(n,tuple):
        n = list(n)
    if isinstance(n[0],float) and (n[0]<1.): # a vector/list of fractions
        n = n*clsz
    # take care for the seed:
    if seed is not None:
        numpy.random.seed(seed)
    # now generate the data:
    i=0  # first class is special:
    x1 = seldat(x,i)
    if (n[i]==clsz[i]):
        # take a bootstrap sample:
        I = numpy.random.randint(0,n[i],n[i])
    elif (n[i]<clsz[i]):
        I = numpy.random.permutation(range(clsz[i]))
        I = I[0:int(n[i])]
    else:
        I = numpy.random.randint(clsz[i],size=int(n[i]))
    out = x1[I,:]
    allI = range(clsz[i])
    J = numpy.setdiff1d(allI,I)
    leftout = x1[J,:]
    # now the other classes:
    for i in range(1,nrcl):
        xi = seldat(x,i)
        if (n[i]==clsz[i]):
            # take a bootstrap sample:
            I = numpy.random.randint(0,n[i],n[i])
        elif (n[i]<clsz[i]):
            I = numpy.random.permutation(range(clsz[i]))
            I = I[0:int(n[i])]
        else:
            I = numpy.random.randint(clsz[i],size=int(n[i]))
        out = out.concatenate(xi[I,:])
        allI = range(clsz[i])
        J = numpy.setdiff1d(allI,I)
        leftout = leftout.concatenate(xi[J,:])

    return out,leftout

def gendatr(x,targets):
    """
    Generate a regression dataset

          a = gendatr(X,Y)

    Generate a regression dataset from data matrix X and target values
    Y. Data matrix X should be NxD, where N is the number of objects,
    and D the feature dimensionality. Target Y should be Nx1.

    Example:
    x = numpy.random.randn(100,2)
    y = numpy.sin(x[:,0])*numpy.sin(x[:,1])
    a = gendatr(x,y)
    """
    a = prdataset(x,targets)
    a.targettype = 'regression'
    return a

############ NEW FUNCTIONS ############
from numpy.random import default_rng

def exprnd(mu=0, m=0, n=0):
    """
    EXPRND Random matrices from exponential distribution.
    R = EXPRND(MU) returns a matrix of random numbers chosen   
    from the exponential distribution with parameter MU.
    The size of R is the size of MU.
    Alternatively, R = EXPRND(MU,M,N) returns an M by N matrix. 
    """
    if mu <= 0:
        raise ValueError("MU is not a positive number!")

    rng = default_rng()

    # Is this the wanted size in case m and n are not given?
    if m == 0 or n == 0:
        exp_mat = rng.exponential(mu, (mu,mu))
    else:
        exp_mat = rng.exponential(mu, (m,n))

    # No target values - is this a problem?
    exp_mat = prdataset(exp_mat)
    exp_mat.targettype = 'exponential'

    return exp_mat


import numpy
import math
import numpy.matlib
from scipy.spatial import distance_matrix
# UNTESTED
def gendatk(A=0, N=[], k=1, stdev=1):
    '''
    GENDATK K-Nearest neighbor data generation
    
        B = GENDATK(A,N,K,S)
    
    INPUT
        A  Dataset
        N  Number of points (optional; default: 50)
        K  Number of nearest neighbors (optional; default: 1)
        S  Standard deviation (optional; default: 1)

    OUTPUT
        B  Generated dataset
    
    DESCRIPTION 
        Generation of N points using the K-nearest neighbors of objects in the dataset A. First, N points of A are chosen in a random order. Next, to each of these points and for each direction (feature), a Gaussian-distributed 
        offset is added with the zero mean and the standard deviation: S * the mean signed difference between the point of A under consideration and its K nearest neighbors in A. 
        
        The result of this procedure is that the generated  points follow the local density properties of the point from which they originate.
        
        If A is a multi-class dataset the above procedure is followed class by class, neglecting objects of other classes and possibly unlabeled objects.
        
        If N is a vector of sizes, exactly N(I) objects are generated for class I. Default N is 100 objects per class.
    '''
    
    if not A:
        raise ValueError("Dataset missing!")
    if len(A) == 0:
        raise ValueError("Empty dataset!")

    m, n, c = getsize(A)
    prior = A.getprior()

    if len(N) == 0:
        N = numpy.matlib.repmat(50, 1, c)
    N = genclass(N, prior)
    lablist = A.lablist()
    B = []
    labels = []
    for i in range(c):
        a = __getitem__(A,j)
        a.sort()
        D, I = spa.distance_matrix(a, a)
        I = I[2:k+1,:]
        alf = numpy.random.randn(k,N[j]) * stdev
        nu = math.ceil(N[j] / getsize(a,1))
        J = numpy.random.permutation(getsize(a,1))
        J = numpy.matlib.repmat(J, nu, 1).conj().T
        J = J[1:N[j]]
        b = numpy.zeros(N[j], n)

        for f in range(n):
            b[:,f] = a[J,f] + sum(((a[J,f]*numpy.ones((1,k)) - numpy.reshape(a[I[:, J],f], k, N[j]), order="F").conj().T * alf.conj().T).conj().T / k, 1).conj().T
        B = np.concatenate((B,b))

    C = A
    C.setdata(B)
    return C

import numpy
import math
import numpy.matlib
from scipy.spatial import distance_matrix

def gendatp(A=None, N=None, s=0, G=None):
    '''
    GENDATP Parzen density data generation
    
        B = GENDATP(A,N,S,G)
    
    INPUT
        A  Dataset
        N  Number(s) of points to be generated (optional; default: 50 per class)
        S  Smoothing parameter(s) (optional; default: a maximum likelihood estimate based on A)
        G  Covariance matrix used for generation of the data  (optional; default: the identity matrix)
    
    OUTPUT
        B  Dataset of points generated according to Parzen density
    
    DESCRIPTION  
        Generation of a dataset B of N points by using the Parzen estimate of the density of A based on a smoothing parameter S. N might be a row/column vector with different numbers for each class. Similarly, S might be a vector with different smoothing parameters for each class. If S = 0, then S is determined by a maximum likelihood estimate using PARZENML. If N is a vector, then exactly N(I) objects are generated for the class I. G is the covariance matrix to be used for generating the data. G may be a 3-dimensional matrix storing separate covariance matrices for each class.
    '''
    if type(A) == 'class NoneType':
       raise NameError("Data set, {}, is not defined!".format(A))

    if N is None:
        N = 50*nrclasses(A)
    if G is None:
        G = numpy.identity(max(getsize(A,1), getsize(A,2)))

    m, k, c = getsize(A)
    p = A.getprior()

    if len(s) == 1:
        s = numpy.matlib.repmat(s, 1, c)
    if len(s) != c:
        raise ValueError("Wrong number of smoothing parameters: expected {}, got {}".format(c, len(s)))

    # If covariance matrices not specified, identity matrix assumed
    covmatrix = numpy.identity(max(getsize(A,1), getsize(A,2)))

    # if covariance matrix is not the identity matrix
    if G != covmatrix:
        covmat_flag = 0
        if numpy.ndim(G) == 2:
            G = numpy.matlib.repmat(G, [1,1,c])
        if getsize(G, 1) != k or getsize(G, 2) != k or getsize(G, 3) != c:
            raise VelueError("Coariance matrix has wrong size: expected {0}, got {1}".format([k,k,c], getsize(G)))
    else:
        covmat_flag = 1

    N = genclass(N, p)
    lablist = A.lablist()
    B = []
    labels = []

    for j in range(c):
        a = __getitem__(A, j)
        a = prdataset(a)
        ma = getsize(a, 1)
        if s[j] == 0:
            h = parzenml(a)
        else:
            h = s[j]

        # Missing gendatgauss
        if not covmat:
            b = numpy.multiply(a[math.ceil[numpy.random.randn(N[j], 1) * ma], :] + numpy.random.randn(N[j], k), numpy.matlib.repmat(h,N[j],k))
        else:
            b = numpy.multiply(a[math.ceil[numpy.random.randn(N[j], 1) * ma], :] + gendatgauss(N[j], numpy.zeros(1, k), G[:,:,j]), numpy.matlib.repmat(h,N[j],k))
        B = [B,b]
        labels = [labels, numpy.matlib.repmat(lablist[j,:], N[j], 1)]
    B = prdataset(B, labels)
    B.prior = p
    B.setname(A.getname())

    return B

import matplotlib.pyplot as plt
from numpy.random import default_rng
# 2d generate and plot multivariate gaussian - currently working on separate plot method

def gen_gauss_and_plot_2d(N=50, u=0, g=0):
    '''
    @var classes - a scalar, number of classes
    @var density - an array of densities
    @var u - a matrix, mean matrix
    @var g - a matrix, cov matrix
    @var N - a scalar, the total number of points
    @var Ns - size (number of samples to generate)

    Generation of N K-dimensional Gaussian distributed samples for C classes.
    The covariance matrices should be specified in G (size K*K*C) and the means, labels and prior probabilities can be defined by the dataset U with size (C*K). If U is not a dataset, it should be a C*K matrix and A will be a dataset with C classes.

    Usecase:
        u = [[10, 5], [-10, -5]]
        g = [[[9, 5], 
            [5, 9]],  

            [[5, 0], 
            [0, 5]]]
        N = 1000

        labels=['classe1', 'classe2']
        dataset = gen_gauss_and_plot_2d(N, u, g, labels)
    '''
    if not u:
        u = numpy.zeros(N,1)
    if not g:  
        g = numpy.eye(N)

    g = numpy.array(g)
    u = numpy.array(u)

    if g.shape[2] > 2:
        raise ValueError('Covariate matrix is 3d not 2d!')

    if len(u[0]) > 2:
        raise ValueError('Mean matrix is formated for 3d not 2d!')

    if len(g) != len(u):
        raise ValueError('Matrix cov and mean have different lengths!')

    density = []

    # The same random density for all classes else dataset cannot be made (different dimensions)
    rand_density = round(random.random(), 1)
    for i in range(len(g)):
        density.append(rand_density)

    density = numpy.array(density)
    Ns = (N*density).astype(int)
    dataset = []
    # This line is responsible to generate len(density) number of classes
    for i in range(len(density)):
        rgb = numpy.random.rand(3,)
        x = numpy.random.multivariate_normal(u[i], g[i], Ns[i]).T
        dataset.append(x)
        plt.scatter(x[0], x[1], color=rgb)
    plt.show()

    return dataset

def gauss(N=50, u=0, g=0):
    '''
    @var classes - a scalar, number of classes
    @var density - an array of densities
    @var u - a matrix, mean matrix
    @var g - a matrix, cov matrix
    @var N - a scalar, the total number of points
    @var Ns - size (number of samples to generate)

    Generation of N K-dimensional Gaussian distributed samples for C classes.
    The covariance matrices should be specified in G (size K*K*C) and the means, labels and prior probabilities can be defined by the dataset U with size (C*K). If U is not a dataset, it should be a C*K matrix and A will be a dataset with C classes.

    Usecase:
        u = [[10, 5], [-10, -5]]
        g = [[[9, 5], 
            [5, 9]],  

            [[5, 0], 
            [0, 5]]]
        N = 1000

        labels=['classe1', 'classe2']
        dataset = gauss(N, u, g, labels)
    '''
    if not u:
        u = numpy.zeros(N,1)
    if not g:  
        g = numpy.eye(N)

    g = numpy.array(g)
    u = numpy.array(u)

    if g.shape[2] > 2:
        raise ValueError('Covariate matrix is 3d not 2d!')

    if len(u[0]) > 2:
        raise ValueError('Mean matrix is formated for 3d not 2d!')

    if len(g) != len(u):
        raise ValueError('Matrix cov and mean have different lengths!')

    density = []

    # The same random density for all classes else dataset cannot be made (different dimensions)
    rand_density = round(random.random(), 1)
    for i in range(len(g)):
        density.append(rand_density)

    density = numpy.array(density)
    Ns = (N*density).astype(int)
    dataset = []
    # This line is responsible to generate len(density) number of classes
    for i in range(len(density)):
        rgb = numpy.random.rand(3,)
        x = numpy.random.multivariate_normal(u[i], g[i], Ns[i]).T
        dataset.append(x)

    return dataset

import math
# UNTESTED
def gendatdd(n=100, d=2):
    '''
    Generates a 2-class data set containing N points in 
    a D-dimensional distribution.
        A = GENDATDD (N,D) 
     
    In this distribution, 2 randomly chosen 
    dimensions contain fully separated Gaussian distributed data; the others 
    contain unit covariance Gaussian noise.
    '''
    data = gen_gauss_and_plot_2d(n, 2*numpy.zeroes((1, d)), 5*numpy.eye(d))

    a = gen_gauss_and_plot_2d(math.floor(n/2),[0, 0],numpy.array([[3, -2.5], [-2.5, 3]]))
    
    b = gen_gauss_and_plot_2d(math.ceil(n/2), [4, 4],numpy.array([[3, -2.5], [-2.5, 3]]))
    
    p = numpy.random.permutation(d)
    data[:,p[0:1]] = numpy.block([[a], [b]])

    labs = [numpy.ones((math.floor(n/2), 1)), [2*numpy.ones((math.ceil(n/2),1))]]

    data = prdataset(data, labs)
    data.name = 'Gaussian dataset'
    return data