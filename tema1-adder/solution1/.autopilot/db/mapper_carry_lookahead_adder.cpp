#include <systemc>
#include <list>
#include <map>
#include <vector>
#include <iostream>
#include "hls_stream.h"
#include "ap_int.h"
#include "ap_fixed.h"
using namespace std;
using namespace sc_dt;

namespace bcsim
{
  struct Buffer {
    char *first;
    Buffer(char *addr) : first(addr)
    {
    }
  };

  struct DBuffer : public Buffer {
    size_t ufree;

    DBuffer(size_t usize) : Buffer(nullptr), ufree(1<<10)
    {
      first = new char[usize*ufree];
    }

    ~DBuffer()
    {
      delete[] first;
    }
  };

  struct CStream {
    char *front;
    char *back;
    size_t num;
    size_t usize;
    std::list<Buffer*> bufs;
    bool dynamic;

    CStream() : front(nullptr), back(nullptr),
                num(0), usize(0), dynamic(true)
    {
    }

    ~CStream()
    {
      for (Buffer *p : bufs) {
        delete p;
      }
    }

    template<typename T>
    T* data()
    {
      return (T*)front;
    }

    template<typename T>
    void transfer(hls::stream<T> *param)
    {
      while (!empty()) {
        param->write(*(T*)nextRead());
      }
    }

    bool empty();
    char* nextRead();
    char* nextWrite();
  };

  bool CStream::empty()
  {
    return num == 0;
  }

  char* CStream::nextRead()
  {
    assert(num > 0);
    char *res = front;
    front += usize;
    --num;
    return res;
  }

  char* CStream::nextWrite()
  {
    if (dynamic) {
      if (static_cast<DBuffer*>(bufs.back())->ufree == 0) {
        bufs.push_back(new DBuffer(usize));
        back = bufs.back()->first;
      }
      --static_cast<DBuffer*>(bufs.back())->ufree;
    }
    char *res = back;
    back += usize;
    ++num;
    return res;
  }

  std::list<CStream> streams;
  std::map<char*, CStream*> prebuilt;

  CStream* createStream(size_t usize)
  {
    streams.emplace_front();
    CStream &s = streams.front();
    {
      s.dynamic = true;
      s.bufs.push_back(new DBuffer(usize));
      s.front = s.bufs.back()->first;
      s.back = s.front;
      s.num = 0;
      s.usize = usize;
    }
    return &s;
  }

  template<typename T>
  CStream* createStream(hls::stream<T> *param)
  {
    CStream *s = createStream(sizeof(T));
    {
      s->dynamic = true;
      while (!param->empty()) {
        T data = param->read();
        memcpy(s->nextWrite(), (char*)&data, sizeof(T));
      }
      prebuilt[s->front] = s;
    }
    return s;
  }

  template<typename T>
  CStream* createStream(T *param, size_t usize)
  {
    streams.emplace_front();
    CStream &s = streams.front();
    {
      s.dynamic = false;
      s.bufs.push_back(new Buffer((char*)param));
      s.front = s.back = s.bufs.back()->first;
      s.usize = usize;
      s.num = ~0UL;
    }
    prebuilt[s.front] = &s;
    return &s;
  }

  CStream* findStream(char *buf)
  {
    return prebuilt.at(buf);
  }
}
class AESL_RUNTIME_BC {
  public:
    AESL_RUNTIME_BC(const char* name) {
      file_token.open( name);
      if (!file_token.good()) {
        cout << "Failed to open tv file " << name << endl;
        exit (1);
      }
      file_token >> mName;//[[[runtime]]]
    }
    ~AESL_RUNTIME_BC() {
      file_token.close();
    }
    int read_size () {
      int size = 0;
      file_token >> mName;//[[transaction]]
      file_token >> mName;//transaction number
      file_token >> mName;//pop_size
      size = atoi(mName.c_str());
      file_token >> mName;//[[/transaction]]
      return size;
    }
  public:
    fstream file_token;
    string mName;
};
extern "C" char carry_lookahead_adder(char*, char*, char*);
extern "C" char apatb_carry_lookahead_adder_hw(volatile void * __xlx_apatb_param_a, volatile void * __xlx_apatb_param_b, volatile void * __xlx_apatb_param_sum) {
  // Collect __xlx_a__tmp_vec
  vector<sc_bv<1> >__xlx_a__tmp_vec;
  for (int j = 0, e = 16; j != e; ++j) {
    __xlx_a__tmp_vec.push_back(((char*)__xlx_apatb_param_a)[j]);
  }
  int __xlx_size_param_a = 16;
  int __xlx_offset_param_a = 0;
  int __xlx_offset_byte_param_a = 0*1;
  char* __xlx_a__input_buffer= new char[__xlx_a__tmp_vec.size()];
  for (int i = 0; i < __xlx_a__tmp_vec.size(); ++i) {
    __xlx_a__input_buffer[i] = __xlx_a__tmp_vec[i].range(0, 0).to_uint64();
  }
  // Collect __xlx_b__tmp_vec
  vector<sc_bv<1> >__xlx_b__tmp_vec;
  for (int j = 0, e = 16; j != e; ++j) {
    __xlx_b__tmp_vec.push_back(((char*)__xlx_apatb_param_b)[j]);
  }
  int __xlx_size_param_b = 16;
  int __xlx_offset_param_b = 0;
  int __xlx_offset_byte_param_b = 0*1;
  char* __xlx_b__input_buffer= new char[__xlx_b__tmp_vec.size()];
  for (int i = 0; i < __xlx_b__tmp_vec.size(); ++i) {
    __xlx_b__input_buffer[i] = __xlx_b__tmp_vec[i].range(0, 0).to_uint64();
  }
  // Collect __xlx_sum__tmp_vec
  vector<sc_bv<1> >__xlx_sum__tmp_vec;
  for (int j = 0, e = 16; j != e; ++j) {
    __xlx_sum__tmp_vec.push_back(((char*)__xlx_apatb_param_sum)[j]);
  }
  int __xlx_size_param_sum = 16;
  int __xlx_offset_param_sum = 0;
  int __xlx_offset_byte_param_sum = 0*1;
  char* __xlx_sum__input_buffer= new char[__xlx_sum__tmp_vec.size()];
  for (int i = 0; i < __xlx_sum__tmp_vec.size(); ++i) {
    __xlx_sum__input_buffer[i] = __xlx_sum__tmp_vec[i].range(0, 0).to_uint64();
  }
  // DUT call
  char ap_return = carry_lookahead_adder(__xlx_a__input_buffer, __xlx_b__input_buffer, __xlx_sum__input_buffer);
// print __xlx_apatb_param_a
  sc_bv<1>*__xlx_a_output_buffer = new sc_bv<1>[__xlx_size_param_a];
  for (int i = 0; i < __xlx_size_param_a; ++i) {
    __xlx_a_output_buffer[i] = __xlx_a__input_buffer[i+__xlx_offset_param_a];
  }
  for (int i = 0; i < __xlx_size_param_a; ++i) {
    ((char*)__xlx_apatb_param_a)[i] = __xlx_a_output_buffer[i].to_uint();
  }
// print __xlx_apatb_param_b
  sc_bv<1>*__xlx_b_output_buffer = new sc_bv<1>[__xlx_size_param_b];
  for (int i = 0; i < __xlx_size_param_b; ++i) {
    __xlx_b_output_buffer[i] = __xlx_b__input_buffer[i+__xlx_offset_param_b];
  }
  for (int i = 0; i < __xlx_size_param_b; ++i) {
    ((char*)__xlx_apatb_param_b)[i] = __xlx_b_output_buffer[i].to_uint();
  }
// print __xlx_apatb_param_sum
  sc_bv<1>*__xlx_sum_output_buffer = new sc_bv<1>[__xlx_size_param_sum];
  for (int i = 0; i < __xlx_size_param_sum; ++i) {
    __xlx_sum_output_buffer[i] = __xlx_sum__input_buffer[i+__xlx_offset_param_sum];
  }
  for (int i = 0; i < __xlx_size_param_sum; ++i) {
    ((char*)__xlx_apatb_param_sum)[i] = __xlx_sum_output_buffer[i].to_uint();
  }
return ap_return;
}
