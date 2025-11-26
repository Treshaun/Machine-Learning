import matplotlib.pyplot as plt
import numpy as np
from tensorflow.keras.datasets import mnist
from tensorflow.keras.layers import Conv2D, Dense, Flatten, MaxPooling2D
from tensorflow.keras.models import Sequential

(x_train, y_train), (x_test, y_test) = mnist.load_data()

x_train = x_train.astype("float32") / 255.0
x_test = x_test.astype("float32") / 255.0

x_train = x_train.reshape(-1, 28, 28, 1)
x_test = x_test.reshape(-1, 28, 28, 1)

model = Sequential(
    [
        Conv2D(32, kernel_size=3, activation="relu", input_shape=(28, 28, 1)),
        MaxPooling2D(pool_size=2),
        Flatten(),
        Dense(128, activation="relu"),
        Dense(10, activation="softmax"),
    ]
)

model.compile(
    optimizer="adam",
    loss="sparse_categorical_crossentropy",
    metrics=["accuracy"],
)

history = model.fit(
    x_train,
    y_train,
    epochs=3,
    batch_size=64,
    validation_split=0.1,
    verbose=2,
)

test_loss, test_acc = model.evaluate(x_test, y_test, verbose=0)
print(f"Test loss: {test_loss:.4f}")
print(f"Test accuracy: {test_acc:.4%}")

sample_images = x_test[:5]
sample_labels = y_test[:5]
probabilities = model.predict(sample_images)
predicted_classes = np.argmax(probabilities, axis=1)

print("Predicted classes for first 5 samples:", predicted_classes)

fig, axes = plt.subplots(1, 5, figsize=(12, 3))
for idx, ax in enumerate(axes):
    ax.imshow(sample_images[idx].squeeze(), cmap="gray")
    ax.set_title(f"Pred: {predicted_classes[idx]}")
    ax.axis("off")
plt.tight_layout()
plt.show()
