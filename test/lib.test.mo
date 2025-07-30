import { test } "mo:test";
import Debug "mo:base/Debug";
import List "mo:core/List";
import Buffer "../src";
import OldBuffer "mo:base/Buffer";
import Iter "mo:core/Iter";

test(
  "fromList",
  func() {
    let list = List.empty<Nat8>();
    let buffer = Buffer.fromList(list);
    buffer.write(1);
    buffer.write(2);

    assert (List.size(list) == 2);
    assert (List.get(list, 0) == 1);
    assert (List.get(list, 1) == 2);
  },
);

test(
  "fromArray",
  func() {
    let array : [var Nat8] = [var 0, 0, 0];
    let buffer = Buffer.fromArray(array, 0);
    buffer.write(1);
    buffer.write(2);

    assert (array[0] == 1);
    assert (array[1] == 2);
    assert (array[2] == 0); // Unwritten index remains unchanged

    let buffer2 = Buffer.fromArray(array, 1);
    buffer2.write(3);
    buffer2.write(4);
    assert (array[0] == 1);
    assert (array[1] == 3);
    assert (array[2] == 4);
  },
);

test(
  "writeMany",
  func() {
    let list = List.empty<Nat8>();
    let buffer = Buffer.fromList<Nat8>(list);
    let items : Iter.Iter<Nat8> = Iter.fromArray<Nat8>([1, 2, 3, 4, 5]);
    Buffer.writeMany(buffer, items);

    assert (List.size(list) == 5);
    assert (List.get(list, 0) == 1);
    assert (List.get(list, 1) == 2);
    assert (List.get(list, 2) == 3);
    assert (List.get(list, 3) == 4);
    assert (List.get(list, 4) == 5);
  },
);

test(
  "fromDeprecatedBuffer",
  func() {
    let oldBuffer = OldBuffer.Buffer<Nat8>(2);
    let buffer = Buffer.fromDeprecatedBuffer(oldBuffer);
    buffer.write(1);
    buffer.write(2);

    assert (oldBuffer.size() == 2);
    assert (oldBuffer.get(0) == 1);
    assert (oldBuffer.get(1) == 2);
  },
);
