# Quantitative High-Frequency Trading

## Purpose

Low-latency infrastructure and HFT systems.

---

## Trigger

Use this skill when the user asks about:
- HFT (high-frequency trading)
- Low-latency systems
- C++ quant development
- Eigen, TBB, OpenMP
- Lock-free data structures
- SIMD optimization
- FIX protocol
- Streaming systems (Kafka, kdb+)
- Network programming

---

## C++ Performance Libraries

### Eigen (Linear Algebra)

```cpp
#include <Eigen/Dense>

using namespace Eigen;

MatrixXd A(3, 3);
VectorXd b(3);

// Solve Ax = b
VectorXd x = A.colPivHouseholderQr().solve(b);

// Matrix operations
MatrixXd C = A * B;
MatrixXd inverse = A.inverse();
EigenSolver<MatrixXd> es(A);
```

### Intel TBB (Parallel Computing)

```cpp
#include <tbb/parallel_for.h>

// TBB parallel loop
tbb::parallel_for(0, n, [&](int i) {
    result[i] = compute(data[i]);
});
```

### OpenMP

```cpp
#include <omp.h>

#pragma omp parallel for
for (int i = 0; i < n; i++) {
    result[i] = compute(data[i]);
}
```

---

## Low-Latency Techniques

### Lock-Free Data Structures

```cpp
#include <atomic>

template<typename T>
class LockFreeQueue {
    struct Node {
        T data;
        std::atomic<Node*> next;
        Node(T val) : data(val), next(nullptr) {}
    };

    std::atomic<Node*> head;
    std::atomic<Node*> tail;

public:
    void push(T val) {
        Node* node = new Node(val);
        Node* old_tail = tail.exchange(node);
        old_tail->next = node;
    }
};
```

### SIMD Vectorization

```cpp
#include <immintrin.h>

// AVX2 vectorized add
void add_arrays(float* a, float* b, float* c, int n) {
    for (int i = 0; i < n; i += 8) {
        __m256 va = _mm256_load_ps(&a[i]);
        __m256 vb = _mm256_load_ps(&b[i]);
        __m256 vc = _mm256_add_ps(va, vb);
        _mm256_store_ps(&c[i], vc);
    }
}
```

---

## Streaming Systems

### Apache Kafka

```python
from kafka import KafkaProducer, KafkaConsumer
import json

# Producer
producer = KafkaProducer(bootstrap_servers=['localhost:9092'])
producer.send('market-data', key=b'AAPL', value=json.dumps(tick).encode())

# Consumer
consumer = KafkaConsumer('market-data', bootstrap_servers=['localhost:9092'])
for message in consumer:
    tick = json.loads(message.value)
    process_tick(tick)
```

### kdb+ (q Language)

High-performance time series database:

```q
/ Load CSV
t: ("DFF";",") 0: `:data.csv

/ Time series query
select avg price by 5 xbar time.minute from t where date within (2024.01.01;2024.12.31)

/ Rolling calculation
update mavg: 20 mavg price by sym from t
```

---

## Network Programming

### FIX Protocol

```python
# Simplified FIX message structure
fix_message = {
    '8': 'FIX.4.4',      # BeginString
    '35': 'D',            # MsgType (New Order Single)
    '49': 'CLIENT',       # SenderCompID
    '56': 'EXCHANGE',     # TargetCompID
    '11': 'ORDER123',     # ClOrdID
    '21': '1',            # HandlInst (Automated)
    '55': 'AAPL',         # Symbol
    '54': '1',            # Side (Buy)
    '38': '100',          # OrderQty
    '40': '2',            # OrdType (Limit)
    '44': '150.00',       # Price
}

def encode_fix(msg):
    return '\x01'.join(f'{k}={v}' for k, v in msg.items())
```

---

## Latency Optimization

### Key Techniques

| Technique | Impact |
|-----------|--------|
| Kernel bypass | 10-100μs saved |
| CPU pinning | Reduce context switches |
| Zero-copy | Avoid memory copies |
| Memory-mapped I/O | Direct hardware access |
| Colocation | Network latency reduction |

### Latency Measurement

```cpp
#include <chrono>

auto start = std::chrono::high_resolution_clock::now();
// ... critical path ...
auto end = std::chrono::high_resolution_clock::now();
auto latency = std::chrono::duration_cast<std::chrono::nanoseconds>(end - start);
```

---

## System Design

### Event-Driven Architecture

```cpp
class OrderHandler {
public:
    void onMarketData(const MarketData& data) {
        if (shouldTrade(data)) {
            sendOrder(data);
        }
    }

    void onOrderUpdate(const OrderUpdate& update) {
        updatePosition(update);
    }

private:
    bool shouldTrade(const MarketData& data);
    void sendOrder(const MarketData& data);
    void updatePosition(const OrderUpdate& update);
};
```

---

## Quick Reference

| Component | Technology | Purpose |
|-----------|------------|---------|
| Linear algebra | Eigen | Matrix operations |
| Parallelism | TBB, OpenMP | Multi-core |
| Messaging | Kafka | Streaming |
| Database | kdb+ | Time series |
| Protocol | FIX | Order routing |
| Optimization | SIMD, lock-free | Latency |
