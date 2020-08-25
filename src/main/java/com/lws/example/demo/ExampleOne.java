package com.lws.example.demo;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * ExampleOne
 *
 * @author lws
 * @date 2020/8/24
 */
public class ExampleOne {
    /**
     * 一、 代码实现以下方法
     * 入参:50 万个不重复的整数。
     * 出参:随机返回 10 万个不重复的整数。
     * 要求:
     * 1、执行时间尽可能少。
     * 2、Maven项目实现项目可编译运行。
     */
    public static void main(String[] args) {
        int n = 500000;
        //生成入参
        List<Integer> input = produceInput(n);

        //获取10万个不重复整数
        List<Integer> result = getRandom(input);
        System.out.println(result.toString());
    }

    /**
     * 生成50万个不重复的入参
     * @param n
     * @return
     */
    private static List<Integer> produceInput(int n) {
        Set<Integer> set = new HashSet<>();
        while (true) {
            set.add((int) (Math.random()*n));
            if (set.size() >= n) {
                break;
            }
        }
        return new ArrayList<>(set);
    }

    /**
     * 根据50万个不重复整数入参获取10万个不重复整数
     * @param input
     * @return
     */
    private static List<Integer> getRandom(List<Integer> input) {
        int n = 500000;
        int m = 100000;
        Set<Integer> set = new HashSet<>();
        while (true) {
            set.add((int) (Math.random()*n));
            if (set.size() >= m) {
                break;
            }
        }
        //组装出参
        List<Integer> result = set.parallelStream().map(s -> input.get(s)).collect(Collectors.toList());
        return result;
    }
}
